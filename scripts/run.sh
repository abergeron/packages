#!/bin/bash

set -e
set -u

cd `dirname $0`


IMAGE_TAG=$1
shift;

docker run --rm \
       -v `realpath ..`:/workspace \
       -w /workspace \
       -e "BUILD_HOME=/workspace" \
       -e "BUILD_USER=$(id -u -n)" \
       -e "BUILD_UID=$(id -u)" \
       -e "BUILD_GROUP=$(id -g -n)" \
       -e "BUILD_GID=$(id -g)" \
       ${IMAGE_TAG} \
       bash --login scripts/run_as_user.sh "$@"
