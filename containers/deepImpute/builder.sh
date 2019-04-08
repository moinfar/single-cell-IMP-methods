#!/usr/bin/env bash

docker build -t moinfar/sc-deepimpute .
docker build -f Dockerfile-gpu -t moinfar/sc-deepimpute:gpu .
