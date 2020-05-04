#!/bin/bash

set -eux

if [ "$target_platform" == "osx-64" ]; then
    # macOS 64 bits
    METAL_OPT="-DUSE_METAL=ON"
    TOOLCHAIN_OPT="-DCMAKE_OSX_DEPLOYMENT_TARGET=10.11"
else
    METAL_OPT=""
    if [ "$target_platform" == "linux-64" ]; then
	# Linux 64 bits
	TOOLCHAIN_OPT="-DCMAKE_TOOLCHAIN_FILE=${RECIPE_DIR}/../cross-linux.cmake"
    else
	# Windows (or 32 bits, which we don't support)
	TOOLCHAIN_OPT=""
    fi
fi

# When cuda is not set, we default to False
cuda=${cuda:-False}

if [ "$cuda" == "True" ]; then
    CUDA_OPT="-DUSE_CUDA=ON -DUSE_CUBLAS=ON -DUSE_CUDNN=ON"
    TOOLCHAIN_OPT=""
    if [ -f "/usr/include/cublas_v2.h" ]; then
        # The default anaconda compilers don't look there
        CXXFLAGS="$CXXFLAGS -I/usr/include -L/usr/lib64"
    fi
else
    CUDA_OPT=""
fi

rm -rf build || true
mkdir -p build
cd build
cmake $METAL_OPT $CUDA_OPT -DUSE_LLVM=$PREFIX/bin/llvm-config -DHIDE_PRIVATE_SYMBOLS=ON -DINSTALL_DEV=ON -DCMAKE_INSTALL_PREFIX="$PREFIX" $TOOLCHAIN_OPT ..
make -j${CPU_COUNT} VERBOSE=1
make install
cd ..
