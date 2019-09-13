#!/bin/bash

set -e
set -u
set -x

if [ "$target_platform" == "osx-64" ]; then
    TOOLCHAIN_OPT="-DCMAKE_OSX_DEPLOYMENT_TARGET=10.11"
else
    if [ "$target_platform" == "linux-64" ]; then
        TOOLCHAIN_OPT="-DCMAKE_TOOLCHAIN_FILE=${RECIPE_DIR}/../cross-linux.cmake"
    else
        TOOLCHAIN_OPT=""
    fi
fi

mkdir build
cd build
cmake -DCMAKE_INSTALL_PREFIX=${PREFIX} \
      -DCMAKE_BUILD_TYPE=Release \
      -DLLVM_ENABLE_ASSERTIONS=ON \
      -DLINK_POLLY_INTO_TOOLS=ON \
      -DLLVM_ENABLE_LIBXML2=OFF \
      -DLLVM_ENABLE_RTTI=OFF \
      -DLLVM_TARGETS_TO_BUILD="host;AMDGPU;NVPTX" \
      -DLLVM_EXPERIMENTAL_TARGETS_TO_BUILD=WebAssembly \
      -DLLVM_INCLUDE_TESTS=OFF \
      -DLLVM_INCLUDE_DOCS=OFF \
      -DLLVM_INCLUDE_EXAMPLES=OFF \
      -DLLVM_ENABLE_THREADS=ON \
      -DLLVM_ENABLE_PIC=ON \
      $TOOLCHAIN_OPT \
      ..
make -j${CPU_COUNT} VERBOSE=1
make install
cd ..
