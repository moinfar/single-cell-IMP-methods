#!/usr/bin/env bash

# i/o
export outputpath=$2

dca "$@"
python tsv_to_csv.py < "$outputpath/mean.tsv" > "$outputpath/mean.csv"
