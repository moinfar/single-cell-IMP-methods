#!/usr/bin/env bash

export inputfile=$1
export outputpath=$2

bash /time_it.sh "$outputpath/time.txt" python runner.py -i $inputfile -o $outputpath "${@:3}"
