#!/usr/bin/env python3
import subprocess
import sys
import time
from pathlib import Path

"""
This script installs the components required for NLP translation with Ollama.

It will install:
- Ollama
- The base model (gemma4:26b)
- The custom model defined in the Modelfile in the current directory

Note: approximately 17 GB of disk space is required for the base and custom models.
"""

MODEL_NAME = "cudatilp"
MODELFILE_PATH = Path("./Modelfile")
BASE_MODEL = "gemma4:26b"

def run(cmd, check=True):
    print(">>", " ".join(cmd))
    return subprocess.run(cmd, check=check)

def run_shell(cmd, check=True):
    print(">>", cmd)
    return subprocess.run(cmd, shell=True, check=check)

def ollama_running():
    try:
        result = subprocess.run(["ollama", "-v"], capture_output=True, text=True)
        return result.returncode == 0
    except FileNotFoundError:
        return False

def main():
    if not MODELFILE_PATH.exists():
        raise FileNotFoundError(f"Modelfile not found: {MODELFILE_PATH}")

    run_shell("curl -fsSL https://ollama.com/install.sh | sh")

    try:
        run(["sudo", "systemctl", "enable", "ollama"])
        run(["sudo", "systemctl", "start", "ollama"])
        time.sleep(3)
    except subprocess.CalledProcessError:
        run(["ollama", "serve"], check=False)
        time.sleep(5)

    if not ollama_running():
        raise RuntimeError("Ollama doesn't respond correctly")

    run(["ollama", "pull", BASE_MODEL])
    run(["ollama", "create", MODEL_NAME, "-f", str(MODELFILE_PATH)])

    print(f"Model created: {MODEL_NAME}")

if __name__ == "__main__":
    try:
        main()
    except Exception as e:
        print(f"Error: {e}", file=sys.stderr)
        sys.exit(1)