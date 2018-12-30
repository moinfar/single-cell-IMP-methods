#!/usr/bin/env bash


# r-base:3.4 with bioconductor
cd _bio_r_base
export rver=3.4.2
sh ./builder.sh
cd ..

# python:3.4 with some good stuff (like pandas)
cd _bio_py
export rver=3.4.0
sh ./builder.sh
cd ..

# scimpute
cd scImpute
sh ./builder.sh
cd ..

