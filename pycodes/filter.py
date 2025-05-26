import os
import pandas as pd

cols = None
filtered_dfs = []

# 공통 컬럼 추출
for f in os.listdir("csv_data"):
    if f.endswith(".csv"):
        df = pd.read_csv(os.path.join("csv_data", f), nrows=0)
        if cols is None:
            cols = list(df.columns)
        else:
            cols = [c for c in cols if c in df.columns]

os.makedirs("filter_data", exist_ok=True)

# 필터링 및 개별 저장 + 병합용 리스트에 추가
for f in os.listdir("csv_data"):
    if f.endswith(".csv"):
        input_path = os.path.join("csv_data", f)
        output_name = f"filter_{f}"
        output_path = os.path.join("filter_data", output_name)

        try:
            df = pd.read_csv(input_path, low_memory=False)
            df = df[cols]

            filtered_df = df[
                ((df["BS3_1"] == 1.0) & (df["BS12_47"] == 8.0)) |
                ((df["BS3_1"] == 3.0) & (df["BS12_47"] == 1.0))
            ]

            filtered_df.to_csv(output_path, index=False, encoding="utf-8")
            filtered_dfs.append(filtered_df)

            print(f"Filtered: {output_name} - {len(filtered_df)} rows, {len(filtered_df.columns)} columns")

        except Exception as e:
            print(f"Failed: {f} - {e}")

# 병합 후 저장
if filtered_dfs:
    merged_df = pd.concat(filtered_dfs, ignore_index=True)
    merged_df.to_csv("filter_data/merged_filtered.csv", index=False, encoding="utf-8")
    print(f"Merged filtered data saved: {len(merged_df)} rows, {len(merged_df.columns)} columns")
else:
    print("No filtered data to merge.")
