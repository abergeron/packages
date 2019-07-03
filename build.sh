#!/bin/bash

set -e
set -u

./docker/build.sh
./conda/build.sh
