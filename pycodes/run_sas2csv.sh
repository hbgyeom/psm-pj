#!/bin/bash
docker run --rm -v "$PWD":/app -w /app "$(basename "$PWD")" python3 sas2csv.py
