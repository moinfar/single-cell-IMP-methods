#!/usr/bin/env bash

# i/o
export inputpath=$1
export outdir=$2

mkdir ./results
./DECODE $inputpath "${@:3}"
mv ./results $2
