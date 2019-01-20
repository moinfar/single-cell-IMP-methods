#!/usr/bin/env bash

# i/o
export inputpath=$1
export outdir=$2

mkdir "$outdir"
bash extract_cols.sh "$inputpath" ./cols.txt
bash /time_it.sh "$outdir/time.txt" ./DECODE -i "$inputpath" -t csv -o "$outdir" -g cols.txt "${@:3}"
