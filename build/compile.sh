#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " Compiling kernel"
echo "======================================"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/env.sh"

ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
KERNEL_DIR="${ROOT_DIR}/${KERNEL_PATH}"

cd "${KERNEL_DIR}"

export ARCH="${ARCH}"
export SUBARCH="${SUBARCH}"
export CC="${CC}"
export LLVM="${LLVM}"
export LLVM_IAS="${LLVM_IAS}"
export CROSS_COMPILE="${CROSS_COMPILE}"
export CCACHE_DIR="${CCACHE_DIR}"

mkdir -p "${BUILD_DIR}"

echo "[STEP] Loading defconfig..."
make O="${BUILD_DIR}" "vendor/${DEFCONFIG}"

echo "[STEP] Building kernel..."
make \
    O="${BUILD_DIR}" \
    -j"$(nproc)" \
    LLVM=1 \
    LLVM_IAS=1 \
    Image Image.gz modules dtbs \
    2>&1 | tee build.log

echo "[OK] Kernel compiled successfully."
