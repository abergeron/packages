#!/bin/bash

set -e
set -u

cd `dirname $0`

mkdir -p ./conda/srccache

echo "### BUILD CPU"
../scripts/run.sh conda_cpu ./conda/build_cpu.sh
echo "### BUILD CUDA 9.0"
../scripts/run.sh conda_cuda90 ./conda/build_cuda.sh
echo "### BUILD CUDA 10.0"
../scripts/run.sh conda_cuda100 ./conda/build_cuda.sh

