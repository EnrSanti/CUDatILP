import pandas as pd

input_file = "Dry_Bean_Dataset-Dry_Beans_Dataset.csv"
output_file = "Dry_Bean_Dataset-Dry_Beans_Dataset_shuffled.csv"

# Read the CSV
df = pd.read_csv(input_file)

# Shuffle the rows
df = df.sample(frac=1, random_state=None).reset_index(drop=True)

# Save the shuffled CSV
df.to_csv(output_file, index=False)

print(f"Shuffled file saved as '{output_file}'")