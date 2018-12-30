#!/usr/bin/env bash

# r-base:3.4 with bioconductor
cd containers/_bio_r_base
export rver=3.5.1
sh ./builder.sh
cd ../..

# python:3.6 with some good stuff (like pandas)
cd containers/_bio_py
export rver=3.6
sh ./builder.sh
cd ../..

# python:2.7 with some good stuff (like pandas)
cd containers/_bio_py
export rver=2.7
sh ./builder.sh
cd ../..

# scimpute
cd containers/scImpute
sh ./builder.sh
cd ../..

# MAGIC
cd containers/MAGIC
sh ./builder.sh
cd ../..

# UNCURL
cd containers/UNCURL
sh ./builder.sh
cd ../..
