#!/usr/bin/env python3
"""
Modernized GUI front-end for background_2.py using ttkbootstrap.

- Pick a CSV dataset (rows -> facts).
- Optionally pick a .lp background knowledge file (rules).
- Choose a test set: either a separate CSV file, or a percentage
  of the training CSV split off randomly.
- Runs the stratification check + TP-fixpoint evaluator (from
  background_2.py) on the combined program and shows the
  resulting answer set(s).
"""

import os
import csv
import random
import tempfile
import tkinter as tk
from tkinter import messagebox, filedialog

# Using ttkbootstrap for beautiful, flat modern widgets with crisp font rendering
import ttkbootstrap as tb
from ttkbootstrap.constants import *
import ttkbootstrap.scrolled as scrolled

# Importing from the subfolder package as structured previously
from algos import background_2 as bg


# ---------------------------------------------------------------------
# CSV -> ASP facts
# ---------------------------------------------------------------------

def value_to_term(value):
    value = value.strip()
    try:
        return str(int(value))
    except ValueError:
        pass
    try:
        f = float(value)
        return repr(f)
    except ValueError:
        pass
    escaped = value.replace("\\", "\\\\").replace('"', '\\"')
    return f'"{escaped}"'


def sanitize_pred_name(name):
    name = name.strip().lower()
    out = []
    for ch in name:
        if ch.isalnum() or ch == "_":
            out.append(ch)
        else:
            out.append("_")
    if not out or not (out[0].isalpha() or out[0] == "_"):
        out.insert(0, "c_")
    return "".join(out)


def rows_to_facts(rows, header, start_id=0):
    preds = [sanitize_pred_name(h) for h in header]
    facts = []
    rid = start_id
    for row in rows:
        for pred, val in zip(preds, row):
            term = value_to_term(val)
            facts.append(f"{pred}({rid},{term}).")
        rid += 1
    return facts, rid


def read_csv(path):
    with open(path, newline="", encoding="utf-8") as f:
        reader = csv.reader(f)
        rows = list(reader)
    if not rows:
        raise ValueError("Empty CSV file")
    header = rows[0]
    data = rows[1:]
    return header, data


# ---------------------------------------------------------------------
# Run the background_2 pipeline
# ---------------------------------------------------------------------

def run_pipeline(program_text):
    with tempfile.NamedTemporaryFile(
        mode="w", suffix=".lp", delete=False, encoding="utf-8"
    ) as tmp:
        tmp.write(program_text)
        tmp_path = tmp.name

    try:
        try:
            dep, rex = bg.parse_file(tmp_path)
        except RuntimeError as e:
            return f"Parse error:\n{e}"

        stratified, sccs, violating = bg.check_stratified(
            dep.predicates, dep.pos_edges, dep.neg_edges
        )

        lines = []
        if not stratified:
            lines.append("PROGRAM IS NOT STRATIFIED")
            for u, v in violating:
                lines.append(f"  {u} -|> {v}")
            return "\n".join(lines)

        lines.append("Program is stratified.")
        lines.append("")
        lines.append("SCCs:")
        for scc in sccs:
            lines.append(f"  {scc}")

        pred_stratum = bg.compute_strata(
            dep.predicates, dep.pos_edges, dep.neg_edges, sccs
        )

        lines.append("")
        lines.append("Strata:")
        for p in sorted(pred_stratum, key=lambda p: (pred_stratum[p], p)):
            lines.append(f"  {pred_stratum[p]}: {p}")

        try:
            answer_set = bg.evaluate(rex.rules, rex.facts, pred_stratum)
        except ValueError as e:
            lines.append("")
            lines.append(f"Evaluation error: {e}")
            return "\n".join(lines)

        lines.append("")
        lines.append(f"Answer set ({len(answer_set)} atoms):")
        for f in sorted(answer_set, key=lambda x: (x[0], x[1:])):
            pred = f[0]
            args = f[1:]
            if args:
                arg_str = ",".join(map(str, args))
                lines.append(f"  {pred}({arg_str})")
            else:
                lines.append(f"  {pred}")

        return "\n".join(lines)

    finally:
        try:
            os.remove(tmp_path)
        except OSError:
            pass


# ---------------------------------------------------------------------
# Modern UI Class using ttkbootstrap
# ---------------------------------------------------------------------

class App(tb.Window):
    def __init__(self):
        # Using the clean, dark "darkly" theme which fits modern Linux systems smoothly
        super().__init__(themename="darkly")

        self.title("CUD@ILP2")
        self.geometry("850x800")
        self.minsize(650, 600)

        # Reactive Variables
        self.csv_path_var = tk.StringVar()
        self.lp_path_var = tk.StringVar()
        self.test_mode_var = tk.StringVar(value="split")
        self.test_file_path_var = tk.StringVar()
        self.split_ratio_var = tk.StringVar(value="0.2")
        self.shuffle_seed_var = tk.StringVar(value="42")

        self._build_ui()

    def _build_ui(self):
        # Window structural scaling grid config
        self.grid_columnconfigure(0, weight=1)
        self.grid_rowconfigure(4, weight=1)

        pad_options = {"padx": 16, "pady": 10, "sticky": "nsew"}

        # --- Section 1: Training Dataset Input ---
        self.frm_csv = tb.Labelframe(self, text=" Training Dataset (.csv) ", bootstyle="primary")
        self.frm_csv.grid(row=0, column=0, **pad_options)
        self.frm_csv.grid_columnconfigure(0, weight=1)

        self.entry_csv = tb.Entry(self.frm_csv, textvariable=self.csv_path_var)
        self.entry_csv.grid(row=0, column=0, padx=(12, 6), pady=12, sticky="ew")
        
        btn_browse_csv = tb.Button(self.frm_csv, text="Browse...", bootstyle="primary", width=12, command=self.choose_csv)
        btn_browse_csv.grid(row=0, column=1, padx=(6, 12), pady=12)

        # --- Section 2: Background Knowledge Input ---
        self.frm_lp = tb.Labelframe(self, text=" Background Knowledge (.lp) — Optional ", bootstyle="secondary")
        self.frm_lp.grid(row=1, column=0, **pad_options)
        self.frm_lp.grid_columnconfigure(0, weight=1)

        self.entry_lp = tb.Entry(self.frm_lp, textvariable=self.lp_path_var)
        self.entry_lp.grid(row=0, column=0, padx=(12, 6), pady=12, sticky="ew")

        btn_browse_lp = tb.Button(self.frm_lp, text="Browse...", bootstyle="secondary", width=12, command=self.choose_lp)
        btn_browse_lp.grid(row=0, column=1, padx=(6, 6), pady=12)
        
        btn_clear_lp = tb.Button(self.frm_lp, text="Clear", bootstyle="secondary-outline", width=8, command=lambda: self.lp_path_var.set(""))
        btn_clear_lp.grid(row=0, column=2, padx=(0, 12), pady=12)

        # --- Section 3: Test Set Settings Block ---
        self.frm_test = tb.Labelframe(self, text=" Test Evaluation Split Strategy ", bootstyle="info")
        self.frm_test.grid(row=2, column=0, **pad_options)
        self.frm_test.grid_columnconfigure(1, weight=1)

        # Radio Split Controls
        self.rb_split = tb.Radiobutton(
            self.frm_test, text="Randomly split percentage from training file", 
            variable=self.test_mode_var, value="split", bootstyle="info", command=self._update_test_widgets
        )
        self.rb_split.grid(row=0, column=0, columnspan=3, sticky="w", padx=16, pady=(12, 6))

        # Nested Inline Numerical Parameter Elements
        self.frm_split_inputs = tb.Frame(self.frm_test)
        self.frm_split_inputs.grid(row=1, column=0, columnspan=3, sticky="w", padx=36, pady=6)

        lbl_fraction = tb.Label(self.frm_split_inputs, text="Test Fraction (0-1):")
        lbl_fraction.pack(side="left", padx=(0, 6))
        self.entry_split = tb.Entry(self.frm_split_inputs, width=8, textvariable=self.split_ratio_var)
        self.entry_split.pack(side="left", padx=(0, 24))

        lbl_seed = tb.Label(self.frm_split_inputs, text="Shuffle Seed:")
        lbl_seed.pack(side="left", padx=(0, 6))
        self.entry_seed = tb.Entry(self.frm_split_inputs, width=10, textvariable=self.shuffle_seed_var)
        self.entry_seed.pack(side="left")

        # Radio File Path Controls
        self.rb_file = tb.Radiobutton(
            self.frm_test, text="Import separate explicit test dataset", 
            variable=self.test_mode_var, value="file", bootstyle="info", command=self._update_test_widgets
        )
        self.rb_file.grid(row=2, column=0, columnspan=3, sticky="w", padx=16, pady=(12, 6))

        self.entry_test_file = tb.Entry(self.frm_test, textvariable=self.test_file_path_var)
        self.entry_test_file.grid(row=3, column=0, columnspan=2, padx=(36, 6), pady=(0, 16), sticky="ew")
        
        self.btn_test_file = tb.Button(self.frm_test, text="Browse...", bootstyle="info", width=12, command=self.choose_test_csv)
        self.btn_test_file.grid(row=3, column=2, padx=(6, 12), pady=(0, 16))

        self._update_test_widgets()

        # --- Section 4: Big CTA Execution Action ---
        self.btn_run = tb.Button(self, text="RUN LEARNING", bootstyle="success", padding=10, command=self.run)
        self.btn_run.grid(row=3, column=0, padx=16, pady=12, sticky="ew")

        # --- Section 5: Console Output Textbox ---
        self.frm_out = tb.Labelframe(self, text=" Execution Terminal Output ", bootstyle="light")
        self.frm_out.grid(row=4, column=0, **pad_options)
        self.frm_out.grid_columnconfigure(0, weight=1)
        self.frm_out.grid_rowconfigure(0, weight=1)

        # Using standard ScrolledText styled natively with bootstyle hooks
        self.output = tb.scrolled.ScrolledText(self.frm_out, font=("Monospace", 10), padding=6, autohide=True)
        self.output.grid(row=0, column=0, padx=8, pady=8, sticky="nsew")

    def _update_test_widgets(self):
        """Swaps operational access states natively depending on operational modes."""
        if self.test_mode_var.get() == "split":
            self.entry_split.configure(state="normal")
            self.entry_seed.configure(state="normal")
            self.entry_test_file.configure(state="disabled")
            self.btn_test_file.configure(state="disabled")
        else:
            self.entry_split.configure(state="disabled")
            self.entry_seed.configure(state="disabled")
            self.entry_test_file.configure(state="normal")
            self.btn_test_file.configure(state="normal")

    # ------------------------------------------------------------
    # Dialogue Utilities (Triggers OS Native System Managers)
    # ------------------------------------------------------------
    def choose_csv(self):
        path = filedialog.askopenfilename(title="Select Training Dataset CSV File Target", filetypes=[("CSV files", "*.csv"), ("All files", "*.*")])
        if path: self.csv_path_var.set(path)

    def choose_lp(self):
        path = filedialog.askopenfilename(title="Select Background Knowledge Rules File Target", filetypes=[("ASP files", "*.lp"), ("All files", "*.*")])
        if path: self.lp_path_var.set(path)

    def choose_test_csv(self):
        path = filedialog.askopenfilename(title="Select Verification Evaluation Dataset CSV File Target", filetypes=[("CSV files", "*.csv"), ("All files", "*.*")])
        if path: self.test_file_path_var.set(path)

    def log(self, text):
        self.output.insert("end", text + "\n")
        self.output.see("end")

    # ------------------------------------------------------------
    # Engine Pipeline Processing Execution Block
    # ------------------------------------------------------------
    def run(self):
        self.output.delete("1.0", "end")

        csv_path = self.csv_path_var.get().strip()
        if not csv_path:
            messagebox.showerror("Missing Data Input", "Please provide a training CSV file.")
            return

        try:
            header, data = read_csv(csv_path)
        except Exception as e:
            messagebox.showerror("Error Parsing File", f"Failed to read CSV:\n{e}")
            return

        bg_text = ""
        lp_path = self.lp_path_var.get().strip()
        if lp_path:
            try:
                with open(lp_path, "r", encoding="utf-8") as f:
                    bg_text = f.read()
            except Exception as e:
                messagebox.showerror("Error Parsing File", f"Failed to read background .lp file:\n{e}")
                return

        if self.test_mode_var.get() == "split":
            try:
                ratio = float(self.split_ratio_var.get())
                seed = int(self.shuffle_seed_var.get())
            except ValueError:
                messagebox.showerror("Invalid Setting Format", "Ensure fraction and seed parameters use standard numeric formatting expressions.")
                return

            if not (0.0 <= ratio <= 1.0):
                messagebox.showerror("Constraint Out of Bounds", "Test subset fraction boundaries must be constrained strictly within the range [0.0, 1.0].")
                return

            rows = list(data)
            rnd = random.Random(seed)
            indices = list(range(len(rows)))
            rnd.shuffle(indices)

            n_test = int(round(len(rows) * ratio))
            test_idx = set(indices[:n_test])

            train_rows = [r for i, r in enumerate(rows) if i not in test_idx]
            test_rows = [r for i, r in enumerate(rows) if i in test_idx]

            self.log(f"Training CSV Target: {csv_path}")
            self.log(f"  ↳ Total parsed lines: {len(rows)}")
            self.log(f"  ↳ Active training rows: {len(train_rows)}")
            self.log(f"  ↳ Randomly segmented validation data rows (Fraction={ratio}): {len(test_rows)}")
            test_header = header

        else:
            test_path = self.test_file_path_var.get().strip()
            if not test_path:
                messagebox.showerror("Missing Split Criteria Target", "Please designate an external separate explicitly dedicated verification dataset test path file target.")
                return

            try:
                test_header, test_rows = read_csv(test_path)
            except Exception as e:
                messagebox.showerror("Error Parsing Target Dataset", f"Failed to successfully parse selected verification path targets:\n{e}")
                return

            train_rows = list(data)
            self.log(f"Training Data Input: {csv_path}")
            self.log(f"  ↳ Active runtime training array size: {len(train_rows)}")
            self.log(f"Explicit Test Data Target: {test_path}")
            self.log(f"  ↳ Read rows size: {len(test_rows)}")

        self.log("")
        if lp_path:
            self.log(f"Loaded Core Logical Axiom Knowledge Database: {lp_path}")
        else:
            self.log("Loaded Core Logical Axiom Knowledge Database: (None Provided)")
        self.log("=" * 70)

        train_facts, next_id = rows_to_facts(train_rows, header, start_id=0)
        train_program = "\n".join(train_facts) + "\n\n" + bg_text

        self.log("\n--- EXECUTING SYSTEM OVER LOGICAL TRAINING ARRAY SUBSPACE ---")
        self.log(run_pipeline(train_program))

        if test_rows:
            test_facts, _ = rows_to_facts(test_rows, test_header, start_id=next_id)
            test_program = "\n".join(test_facts) + "\n\n" + bg_text

            self.log("\n--- EXECUTING SYSTEM OVER LOGICAL VALIDATION TEST SUBSPACE ---")
            self.log(run_pipeline(test_program))
        else:
            self.log("\n(Evaluation cycle ended: No verification targets specified to pass to processor logic engines.)")


if __name__ == "__main__":
    app = App()
    app.mainloop()