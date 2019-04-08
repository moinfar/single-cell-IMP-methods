#!/usr/bin/env bash

docker build -t moinfar/sc-dca .
docker build -f Dockerfile-gpu -t moinfar/sc-dca-gpu .
