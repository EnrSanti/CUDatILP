import pandas as pd

df = pd.read_csv("datasets/PM-acl/merge.csv")
df = df.sample(frac=1, random_state=42).reset_index(drop=True)
df.to_csv("datasets/PM-acl/merge_shuffled.csv", index=False)