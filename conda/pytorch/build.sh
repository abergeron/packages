#!/bin/bash

set -eux

export TH_BINARY_BUILD=1
export PYTORCH_BUILD_VERSION=$PKG_VERSION
export PYTORCH_BUILD_NUMBER=$PKG_BUILDNUM
export BUILD_TEST=0
export MAX_JOBS=${CPU_COUNT}
export BLAS=MKL

cuda=${cuda:-False}

if [ "$cuda" == "True" ]; then
    export USE_CUDA=${cuda_version}
    export USE_SYSTEM_NCCL=0
    export TORCH_CUDA_ARCH_LIST="3.5;5.0+PTX"
    if [[ $cuda_version == 9.0* ]]; then
        export TORCH_CUDA_ARCH_LIST="$TORCH_CUDA_ARCH_LIST;6.0;7.0"
    elif [[ $cuda_version == 9.2* ]]; then
        export TORCH_CUDA_ARCH_LIST="$TORCH_CUDA_ARCH_LIST;6.0;6.1;7.0"
    elif [[ $cuda_version == 10.0* ]]; then
        export TORCH_CUDA_ARCH_LIST="$TORCH_CUDA_ARCH_LIST;6.0;6.1;7.0;7.5"
    fi
    export TORCH_NVCC_FLAGS="-Xfatbin -compress-all"
    #export NCCL_ROOT_DIR=/usr/local/cuda
    #export USE_STATIC_CUDNN=1
    export USE_STATIC_NCCL=1
fi


python setup.py install


# set RPATH of _C.so and similar to $ORIGIN, $ORIGIN/lib and conda/lib
find $SP_DIR/torch -name "*.so*" -maxdepth 1 -type f | while read sofile; do
    echo "Setting rpath of $sofile to " '$ORIGIN:$ORIGIN/lib:$ORIGIN/../../..'
    patchelf --set-rpath '$ORIGIN:$ORIGIN/lib:$ORIGIN/../../..' $sofile
    patchelf --print-rpath $sofile
done

# set RPATH of lib/ files to $ORIGIN and conda/lib
find $SP_DIR/torch/lib -name "*.so*" -maxdepth 1 -type f | while read sofile; do
    echo "Setting rpath of $sofile to " '$ORIGIN:$ORIGIN/lib:$ORIGIN/../../../..'
    patchelf --set-rpath '$ORIGIN:$ORIGIN/lib:$ORIGIN/../../../..' $sofile
    patchelf --print-rpath $sofile
done
