#!/usr/bin/env bash

export inputfile=$1
export outputpath=$2

bash /time_it.sh "$outputpath/time.txt" Rscript runner.R -i $inputfile -o $outputpath "${@:3}"
