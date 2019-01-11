#!/usr/bin/env bash

# r-base:3.5 with bioconductor
cd containers/_bio_r_base
export rver=3.5.1
sh ./builder.sh
cd ../..

# python:3.6 with some good stuff (like pandas)
cd containers/_bio_py
export pyver=3.6
sh ./builder.sh
cd ../..

# python:2.7 with some good stuff (like pandas)
cd containers/_bio_py
export pyver=2.7
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

# BISCUIT
cd containers/BISCUIT
sh ./builder.sh
cd ../..

# DCA
cd containers/DCA
sh ./builder.sh
cd ../..

# DECODE
cd containers/DECODE
sh ./builder.sh
cd ../..

# DrImpute
cd containers/DrImpute
sh ./builder.sh
cd ../..
