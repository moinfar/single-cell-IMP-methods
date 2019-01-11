#!/usr/bin/env bash

# i/o
export inputpath=$1
export outdir=$2

mkdir $outdir
bash extract_cols.sh $inputpath ./cols.txt
./DECODE -i $inputpath -t csv -o $outdir "${@:3}" -g cols.txt
