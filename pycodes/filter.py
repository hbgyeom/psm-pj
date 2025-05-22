import argparse
import pandas as pd
import os

def filter(input_file):
    input_path = os.path.join("csv_data", input_file)
    print(input_path)
    try:
        df = read_csv(input_path)
    except Exception:
        print(f"Failed: {input_path}")

filter("hn20_all.csv")
