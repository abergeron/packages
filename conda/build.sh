#!/bin/bash

set -e
set -u

cd `dirname $0`

../scripts/run.sh conda_cpu ./conda/build_cpu.sh
../scripts/run.sh conda_cuda90 ./conda/build_cuda.sh
../scripts/run.sh conda_cuda100 ./conda/build_cuda.sh

