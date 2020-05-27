#!/bin/bash

set -eux

if [[ ! -z ${BUILD_HOME+x} ]]; then
    conda config --add pkgs_dirs $HOME/.conda/pkgs
    conda config --append pkgs_dirs /opt/conda/pkgs
    # Conda is retarded and freaks out if the following paths/file are not present
    mkdir -p $HOME/.conda/pkgs
    touch $HOME/.conda/pkgs/urls.txt
fi

conda info

# dev dependencies
#conda build --cache-dir=conda/srccache --output-folder=conda/pkg --skip-existing conda/codecov
conda build --cache-dir=conda/srccache --output-folder=conda/pkg --skip-existing conda/pydocstyle

# test dependecies


# run dependencies
conda build --cache-dir=conda/srccache --output-folder=conda/pkg --skip-existing conda/asttokens
conda build --cache-dir=conda/srccache --output-folder=conda/pkg --skip-existing conda/colorful
conda build --cache-dir=conda/srccache --output-folder=conda/pkg --skip-existing conda/prettyprinter
conda build --cache-dir=conda/srccache --output-folder=conda/pkg --skip-existing conda/antlr4-python3-runtime
conda build --cache-dir=conda/srccache --output-folder=conda/pkg --skip-existing conda/llvmlib
conda build --cache-dir=conda/srccache --output-folder=conda/pkg --skip-existing conda/tvm-libs
conda build --cache-dir=conda/srccache --output-folder=conda/pkg --skip-existing conda/tvm
