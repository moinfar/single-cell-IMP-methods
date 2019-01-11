#!/usr/bin/env bash

# i/o
export inputpath=$1
export outdir=$2

mkdir $outdir
./DECODE -i $inputpath -t csv -o $outdir "${@:3}"
