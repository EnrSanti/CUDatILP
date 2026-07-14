#!/usr/bin/env python3
"""
server.py  –  CUD@LP² backend
Serves index.html at / AND the /api/learn endpoint.

Usage:
    python server.py              # http://localhost:5000
    python server.py --port 8080
    python server.py --debug

Place server.py in the same folder as index.html.
"""

import argparse
import io
import json
import os
import sys
import tempfile
import traceback
from timeit import default_timer as timer
import threading
import webbrowser
import time
import numpy as np
from flask import Flask, jsonify, request, send_from_directory
from flask.json.provider import DefaultJSONProvider

class NumpySafeProvider(DefaultJSONProvider):
    """Serialise numpy scalars/arrays that Flask's default encoder chokes on."""
    def default(self, o):
        if isinstance(o, np.integer):  return int(o)
        if isinstance(o, np.floating): return float(o)
        if isinstance(o, np.ndarray):  return o.tolist()
        return super().default(o)

# ── project imports ────────────────────────────────────────────────────────────
# Adjust if server.py lives outside the project root.
sys.path.insert(0, os.path.dirname(os.path.abspath(__file__)))


from src.common.foldrm import *
from src.common.datasets import *
# ──────────────────────────────────────────────────────────────────────────────

# Flask serves static files from the same directory as server.py
HERE = os.path.dirname(os.path.abspath(__file__))
app  = Flask(__name__, static_folder=HERE, static_url_path="")
app.json_provider_class = NumpySafeProvider
app.json = NumpySafeProvider(app)


# ── serve the UI ──────────────────────────────────────────────────────────────

@app.route("/")
def index():
    return send_from_directory(HERE, "index.html")


# ── helpers ───────────────────────────────────────────────────────────────────

def _save_upload(file_storage) -> str:
    """Save a werkzeug FileStorage to a named temp file; return its path."""
    suffix = os.path.splitext(file_storage.filename)[1] or ".tmp"
    fd, path = tempfile.mkstemp(suffix=suffix)
    os.close(fd)
    file_storage.save(path)
    return path


def _cleanup(*paths):
    for p in paths:
        try:
            if p and os.path.exists(p):
                os.remove(p)
        except OSError:
            pass


# ── CORS + debug headers ─────────────────────────────────────────────────────

@app.after_request
def after_request(response):
    response.headers["Access-Control-Allow-Origin"]  = "*"
    response.headers["Access-Control-Allow-Headers"] = "Content-Type"
    response.headers["Access-Control-Allow-Methods"] = "GET, POST, OPTIONS"
    return response


# ── /api/ping (health check) ─────────────────────────────────────────────────

@app.route("/api/ping")
def api_ping():
    return jsonify({"ok": True})


# ── /api/learn ────────────────────────────────────────────────────────────────

@app.route("/api/learn", methods=["POST"])
def api_learn():
    """
    Multipart/form-data fields
    ──────────────────────────
    train_csv   file        required
    test_csv    file        optional  (if absent, split_ratio is used)
    split_ratio float 0-1   optional  default 0.8
    bg_rules    file        optional  .lp background file
    bg_ratio    float 0-1   optional  default 1.0
    label       str         optional  target column name
    features    JSON str    optional  [{"name": "x", "numeric": true}, ...]
    """

    tmp_train = tmp_test = tmp_bg = None

    try:
        # 1. files ─────────────────────────────────────────────────────────────
        if "train_csv" not in request.files:
            return jsonify({"error": "train_csv is required"}), 400

        tmp_train = _save_upload(request.files["train_csv"])

        has_test = "test_csv" in request.files and request.files["test_csv"].filename
        if has_test:
            tmp_test = _save_upload(request.files["test_csv"])

        has_bg = "bg_rules" in request.files and request.files["bg_rules"].filename
        if has_bg:
            tmp_bg = _save_upload(request.files["bg_rules"])

        split_ratio = float(request.form.get("split_ratio", 0.8))
        bg_ratio    = float(request.form.get("bg_ratio",    1.0))

        # 2. column config (from CSV picker modal) ─────────────────────────────
        label_name    = request.form.get("label", None)
        features_json = request.form.get("features", None)

        if features_json:
            features = json.loads(features_json)   # [{"name":…, "numeric":…}, …]
            attrs    = [f["name"] for f in features]
            nums     = [f["name"] for f in features if f.get("numeric", True)]
        else:
            # fallback: infer from CSV header
            with open(tmp_train) as fh:
                header = fh.readline().strip().split(",")
            header = [h.strip().strip('"') for h in header]
            if label_name and label_name in header:
                attrs = [h for h in header if h != label_name]
            else:
                attrs      = header[:-1]
                label_name = header[-1]
            nums = attrs.copy()

        if not label_name:
            return jsonify({"error": "Could not determine label column"}), 400

        # 3. build model & load data ───────────────────────────────────────────
        model      = Classifier(attrs=attrs, numeric=nums, label=label_name)
        data_train = model.load_data(tmp_train)

        if has_test:
            data_test = model.load_data(tmp_test)
        else:
            data_train, data_test = split_data(data_train, ratio=split_ratio)

        # 4. fit ───────────────────────────────────────────────────────────────
        start = timer()

        fit_kwargs = dict(col_names=model.attrs, ratio=bg_ratio)
        print("ratio-----> ",str(bg_ratio))
        if has_bg:
            fit_kwargs["bg_file"] = tmp_bg

        model.fitGPU(data_train, **fit_kwargs)
        elapsed = round(timer() - start, 3)

        # 5. evaluate ──────────────────────────────────────────────────────────
        try:
            Y_hat = model.predict(data_test)
            acc   = get_scores(Y_hat, data_test)
        except Exception as e:
            return jsonify({"error": f"predict/score failed: {e}",
                            "traceback": traceback.format_exc()}), 500

        n_rules = len(model.rules) if model.rules else 0

        # 6. capture print_asp output ──────────────────────────────────────────
        # Use contextlib to safely redirect stdout; never touch sys.stdout directly
        try:
            import contextlib
            buf = io.StringIO()
            with contextlib.redirect_stdout(buf):
                model.print_asp(simple=True)
            hypothesis_text = buf.getvalue().strip()
        except Exception as e:
            # print_asp failed — try to get rules as plain strings another way
            hypothesis_text = ""
            print(f"print_asp error (non-fatal): {e}", file=sys.stderr)

        # last-resort fallback: if hypothesis is still empty, repr the rules
        if not hypothesis_text:
            try:
                hypothesis_text = "\n".join(str(r) for r in model.rules)
            except Exception:
                hypothesis_text = "(could not serialise hypothesis)"

        # coerce everything to plain Python types before serialising
        acc_py     = float(acc)
        n_rules_py = int(n_rules)

        return jsonify({
            "hypothesis": hypothesis_text,
            "meta": (
                f"acc {round(acc_py, 4)} · "
                f"{n_rules_py} rule{'s' if n_rules_py != 1 else ''} · "
                f"{elapsed}s"
            ),
            "accuracy":  round(acc_py, 4),
            "n_rules":   n_rules_py,
            "elapsed_s": elapsed,
        })

    except Exception as exc:
        tb = traceback.format_exc()
        print(tb, file=sys.stderr)
        return jsonify({"error": str(exc), "traceback": tb}), 500

    finally:
        _cleanup(tmp_train, tmp_test, tmp_bg)


# ── entry point ───────────────────────────────────────────────────────────────
def open_browser(host, port):
    # Give Flask a moment to start
    webbrowser.open(f"http://{host}:{port}")

if __name__ == "__main__":
    parser = argparse.ArgumentParser(description="CUD@LP² backend")
    parser.add_argument("--port",  type=int, default=5000)
    parser.add_argument("--host",  default="127.0.0.1",
                        help="use 0.0.0.0 to expose on the local network")
    parser.add_argument("--debug", action="store_true")
    args = parser.parse_args()
    
    threading.Thread(
        target=open_browser,
        args=(args.host, args.port),
        daemon=True
    ).start()

    app.run(host=args.host, port=args.port, debug=args.debug)
    print(f"\n  CUD@LP² :-  →  http://{args.host}:{args.port}\n")
    app.run(host=args.host, port=args.port, debug=args.debug)