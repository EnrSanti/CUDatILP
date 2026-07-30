import math
import pandas as pd

# -----------------------------
# Load benchmark data
# -----------------------------
df = pd.read_csv("benchmark.txt", skipinitialspace=True)

# Remove accidental spaces from column names
df.columns = df.columns.str.strip()

# -----------------------------
# Function to compare two columns
# -----------------------------
def compare(df, serial_col, parallel_col):
    print("\n" + "=" * 60)
    print(f"{serial_col} vs {parallel_col}")
    print("=" * 60)

    # Average over the 5 runs of each benchmark
    avg = (
        df.groupby("Test")[[serial_col, parallel_col]]
          .mean()
          .reset_index()
    )

    # Per-test speedup
    avg["Speedup"] = avg[serial_col] / avg[parallel_col]

    total_serial = avg[serial_col].sum()
    total_parallel = avg[parallel_col].sum()

    overall_speedup = total_serial / total_parallel

    arithmetic = avg["Speedup"].mean()

    geometric = math.exp(
        sum(math.log(x) for x in avg["Speedup"]) / len(avg)
    )

    harmonic = len(avg) / sum(1.0 / x for x in avg["Speedup"])

    print("\nPer-test speedups:")
    print(avg[["Test", "Speedup"]].to_string(index=False))

    print("\nOverall statistics")
    print(f"Total {serial_col:<12}: {total_serial:.4f}")
    print(f"Total {parallel_col:<12}: {total_parallel:.4f}")
    print(f"Overall speedup : {overall_speedup:.4f}x")
    print(f"Arithmetic mean : {arithmetic:.4f}x")
    print(f"Geometric mean  : {geometric:.4f}x")
    print(f"Harmonic mean   : {harmonic:.4f}x")


# -----------------------------
# Perform the three comparisons
# -----------------------------
compare(df, "CUD@ILP", "CUD@ILP2")
compare(df, "FOLD-RM", "CUD@ILP")
compare(df, "FOLD-RM", "CUD@ILP2")