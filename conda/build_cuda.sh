#!/bin/sh

set -e
set -u

# This is a fix for a weird bug in conda that makes it think
# it can't write in /tmp
HOME=/tmp
mkdir -p /tmp/.conda/pkgs
touch /tmp/.conda/pkgs/urls.txt
touch /tmp/.conda/environments.txt


conda build --output-folder=conda/pkg --variants "{cuda: True, cuda_version: ${CUDA_VERSION%.*}}" -c numba conda/tvm-libs
