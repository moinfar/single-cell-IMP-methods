#!/usr/bin/env bash

apt-get update -y
apt-get install time -y

pip install --no-cache-dir networkx==1.11
pip install --no-cache-dir scanpy
pip install --no-cache-dir dca
