#!/usr/bin/env bash

# i/o
export outputpath=$2

bash /time_it.sh "$outputpath/time.txt" dca "$@"

python tsv_to_csv.py < "$outputpath/mean.tsv" > "$outputpath/mean.csv"
