#!/usr/bin/env bash

# i/o
export inputpath=$1
export inputfilename="${inputpath##*/}"
export outputpath=$2
export outputfilename="${outputpath##*/}"
export outdir=$3

# create tmp dir
export data_dir=`mktemp -d`
echo "using tmp directory $data_dir ..."

# integrity checks
if [ "${inputfilename##*.}" != "csv" ]; then
  echo "only csv files are supported for input!"
  exit 1
fi

if [ "${outputfilename##*.}" != "csv" ]; then
  echo "only csv files are supported for output!"
  exit 1
fi

# run algorithm
cp "$inputpath" "$data_dir/$inputfilename"
docker run -v "$data_dir:/data" \
       --rm moinfar/sc-scscope \
       "/data/$inputfilename" "/data/output/" "${@:4}"

# copy results
mkdir -p "$outdir"
cp -r "$data_dir/output/"* "$outdir"
ln -s "$data_dir/output/imputed_values.csv" "$outputpath"

echo "imputed data saved to $outputpath"
