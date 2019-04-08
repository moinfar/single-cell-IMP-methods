#!/usr/bin/env bash

docker build -f Dockerfile-tensorflow -t moinfar/bio-deep-python:tensorflow-3.6 .
docker build -f Dockerfile-pytorch -t moinfar/bio-deep-python:pytorch-3.6 .
