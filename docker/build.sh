#!/bin/bash

set -e
set -u

cd `dirname $0`

docker_build() {
  docker build . -f Dockerfile.$1 -t $1
}


python render_cuda.py 9.2 10.2 11.0

docker_build conda_cpu
docker_build conda_cuda92
docker_build conda_cuda102
#docker_build conda_cuda110

rm Dockerfile.conda_cuda92
rm Dockerfile.conda_cuda102
rm Dockerfile.conda_cuda110
