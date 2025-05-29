#!/bin/bash
docker run --rm -v "$PWD":/app -w /app "$(basename "$PWD")" Rscript D_1_1.R
