#!/usr/bin/env bash

# i/o
export inputpath=$1
export outdir=$2

mkdir $outdir
python /app/deepimpute/deepImpute.py --cell-axis columns -o $outdir/deepimpute.csv $inputpath
python transpose_it.py -i $outdir/deepimpute.csv -o $outdir/deepimpute.csv
