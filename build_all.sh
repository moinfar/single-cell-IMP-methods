#!/usr/bin/env bash

# r-base:3.4 with bioconductor
cd containers/_bio_r_base
export rver=3.5.1
sh ./builder.sh
cd ../..

# python:3.4 with some good stuff (like pandas)
cd containers/_bio_py
export rver=3.6
sh ./builder.sh
cd ../..

# scimpute
cd containers/scImpute
sh ./builder.sh
cd ../..

# scimpute
cd MAGIC
sh ./builder.sh
cd ..
