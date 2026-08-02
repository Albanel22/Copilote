#!/usr/bin/env bash

export DEVICE="kiev"

export KERNEL_REPO="https://github.com/LineageOS/android_kernel_motorola_sm8250.git"

export KERNEL_BRANCH="lineage-23.2"

export KERNEL_PATH="kernel_src"

export BUILD_DIR="out"

export DEFCONFIG="lito-perf_defconfig"

export ARCH="arm64"

export SUBARCH="arm64"

export LLVM=1

export LLVM_IAS=1

export CC=clang

export CROSS_COMPILE=aarch64-linux-gnu-

export CCACHE_DIR="$HOME/.cache/ccache"
