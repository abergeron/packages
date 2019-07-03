#!/bin/bash

set -e
set -u

cd `dirname $0`

docker_build() {
  docker build . -f Dockerfile.$1 -t $1
}


python render_cuda.py 9.0 10.0

docker_build conda_cpu
docker_build conda_cuda90
docker_build conda_cuda100

rm Dockerfile.conda_cuda90
rm Dockerfile.conda_cuda100
