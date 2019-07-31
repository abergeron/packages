#!/bin/bash

set -e
set -u
set -x

cd `dirname $0`


IMAGE_TAG=$1
shift;

# Make sure TMPDIR is set
TMPDIR=${TMPDIR:-/tmp}

USER_HOME=`mktemp -d "$TMPDIR/user.XXXXXXXXXXXX"`

docker run -it --rm \
       -v `realpath ..`:/workspace \
       -v $USER_HOME:/home/user \
       -w /workspace \
       -e "BUILD_HOME=/home/user" \
       -e "BUILD_USER=$(id -u -n)" \
       -e "BUILD_UID=$(id -u)" \
       -e "BUILD_GROUP=$(id -g -n)" \
       -e "BUILD_GID=$(id -g)" \
       ${IMAGE_TAG} \
       bash --login scripts/run_as_user.sh "$@"

rm -rf ${USER_HOME}
