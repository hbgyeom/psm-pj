import pyreadstat
import os

os.makedirs("csv_data", exist_ok=True)

for f in os.listdir("sas_data"):
    if f.endswith(".sas7bdat"):
        try:
            df, _ = pyreadstat.read_sas7bdat(f"sas_data/{f}")
            csv_name = f.replace(".sas7bdat", ".csv")
            df.to_csv(f"csv_data/{csv_name}", index=False, encoding="utf-8")
            print(f"{f} -> {csv_name}")
        except Exception:
            print(f"Failed {f}")
