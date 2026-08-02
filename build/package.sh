#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " Packaging AnyKernel3"
echo "======================================"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/env.sh"

ROOT_DIR="$(cd "${SCRIPT_DIR}/.." && pwd)"
KERNEL_DIR="${ROOT_DIR}/${KERNEL_PATH}"
OUT_DIR="${KERNEL_DIR}/${BUILD_DIR}"

cd "${ROOT_DIR}"

rm -rf anykernel

echo "[INFO] Cloning AnyKernel3..."
git clone --depth=1 \
    https://github.com/kernel-su/AnyKernel3.git \
    anykernel

rm -rf anykernel/.git

IMAGE=""

if [ -f "${OUT_DIR}/arch/arm64/boot/Image.gz" ]; then
    IMAGE="${OUT_DIR}/arch/arm64/boot/Image.gz"
elif [ -f "${OUT_DIR}/arch/arm64/boot/Image" ]; then
    IMAGE="${OUT_DIR}/arch/arm64/boot/Image"
else
    echo "[ERROR] Kernel image not found."
    exit 1
fi

echo "[INFO] Copying kernel image..."
cp "${IMAGE}" anykernel/

echo "[INFO] Copying modules..."
mkdir -p anykernel/modules/system/lib/modules

find "${OUT_DIR}" -name "*.ko" \
    -exec cp {} anykernel/modules/system/lib/modules/ \;

cd anykernel

zip -r9 ../ReSukiSU-AnyKernel3-kiev.zip .

echo "[OK] Package created:"
echo "ReSukiSU-AnyKernel3-kiev.zip"
