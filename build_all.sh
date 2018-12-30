#!/usr/bin/env bash

# r-base:3.4 with bioconductor
cd _bio_r_base
export rver=3.5.1
sh ./builder.sh
cd ..

# python:3.4 with some good stuff (like pandas)
cd _bio_py
export rver=3.6
sh ./builder.sh
cd ..

# scimpute
cd scImpute
sh ./builder.sh
cd ..

# scimpute
cd MAGIC
sh ./builder.sh
cd ..
