#!/bin/bash

set -e
set -u

HOME=/tmp
mkdir -p /tmp/.conda/pkgs
touch /tmp/.conda/pkgs/urls.txt
touch /tmp/.conda/environments.txt

conda build --output-folder=conda/pkg --skip-existing -c numba conda/tvm-libs
conda build --output-folder=conda/pkg --skip-existing conda/tvm
