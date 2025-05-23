import pandas as pd
import os

os.makedirs("column_data", exist_ok=True)

for f in os.listdir("row_data"):
    if f.endswith(".csv"):
        input_path = os.path.join("row_data", f)
        output_name = f"column_{f}"
        output_path = os.path.join("column_data", output_name)

        try:
            df = pd.read_csv(input_path, low_memory=False)

            filtered_df = df[
                ((df["BS3_1"] == 1.0) & (df["BS12_47"] == 8.0)) |
                ((df["BS3_1"] == 3.0) & (df["BS12_47"] == 1.0))
            ]

            filtered_df.to_csv(output_path, index=False, encoding="utf-8")
            print(f"Filtered: {output_name} - {len(filtered_df)} rows")

        except Exception as e:
            print(f"Failed: {f} - {e}")
