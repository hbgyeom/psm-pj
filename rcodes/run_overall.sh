#!/bin/bash
docker run --rm -v "$PWD":/app -w /app "$(basename "$PWD")" Rscript overall.R
