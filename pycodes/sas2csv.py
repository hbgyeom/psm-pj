import pyreadstat
import os

os.makedirs("csv_data", exist_ok=True)

for f in os.listdir("sas_data"):
    if f.endswith(".sas7bdat"):
        input_path = os.path.join("sas_data", f)
        csv_name = f.replace(".sas7bdat", ".csv")
        output_path = os.path.join("csv_data", csv_name)

        try:
            df, _ = pyreadstat.read_sas7bdat(input_path)
            df.to_csv(output_path, index=False, encoding="utf-8")
            print(f"Converted: {csv_name}")

        except Exception as e:
            print(f"Failed: {f} - {e}")
