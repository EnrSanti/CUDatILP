import os
import re

# ==========================
# Hardcoded input folder
# ==========================
INPUT_FOLDER = "./experiments/ai_argicoluture"

def count_body_atoms(rule):
    rule = rule.strip()

    if not rule or rule.startswith("%"):
        return None

    # Facts have no body
    if ":-" not in rule:
        return 0

    body = rule.split(":-", 1)[1].strip()

    if body.endswith("."):
        body = body[:-1]

    # Split on commas outside parentheses
    atoms = re.split(r',(?![^()]*\))', body)

    return len([a.strip() for a in atoms if a.strip()])


def analyze_file(filename):
    total_atoms = 0

    with open(filename, "r", encoding="utf-8") as f:
        for line in f:
            n = count_body_atoms(line)
            if n is not None:
                total_atoms += n

    return total_atoms


def main():
    print(f"{'File':40} {'Total body atoms':>18}")
    print("-" * 60)

    for file in sorted(os.listdir(INPUT_FOLDER)):
        if file.endswith(".txt"):
            path = os.path.join(INPUT_FOLDER, file)
            total = analyze_file(path)
            print(f"{file:40} {total:18d}")


if __name__ == "__main__":
    main()
