#!/bin/bash

set -e
set -u

conda config --add pkgs_dirs $HOME/.conda/pkgs
conda config --append pkgs_dirs /opt/conda/pkgs
# Conda is retarded and freaks out if the following paths/file are not present
mkdir -p $HOME/.conda/pkgs
touch $HOME/.conda/pkgs/urls.txt

conda info

conda build --output-folder=conda/pkg --skip-existing -c numba conda/tvm-libs
conda build --output-folder=conda/pkg --skip-existing conda/tvm
