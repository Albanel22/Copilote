#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " Applying Copilote patches"
echo "======================================"

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/env.sh"

PROJECT_ROOT="$(git rev-parse --show-toplevel)"
KERNEL_DIR="${ROOT_DIR}/${KERNEL_PATH}"

echo "[INFO] Kernel directory : ${KERNEL_DIR}"

if [ ! -d "${KERNEL_DIR}" ]; then
    echo "[ERROR] Kernel source not found."
    exit 1
fi

cd "${KERNEL_DIR}"

echo "[STEP] Installing SUSFS sources..."

mkdir -p include/linux

if [ ! -f "${ROOT_DIR}/susfs.c" ]; then
    echo "[ERROR] susfs.c not found."
    exit 1
fi

if [ ! -f "${ROOT_DIR}/susfs.h" ]; then
    echo "[ERROR] susfs.h not found."
    exit 1
fi

cp "${ROOT_DIR}/susfs.c" fs/
cp "${ROOT_DIR}/susfs.h" include/linux/

echo "[OK] SUSFS installed."

PATCH_DIR="${ROOT_DIR}/patches"

if [ ! -d "${PATCH_DIR}" ]; then
    echo "[ERROR] patches directory not found."
    exit 1
fi

echo "[STEP] Applying patches..."

for patch in "${PATCH_DIR}"/*.patch
do
    [ -f "$patch" ] || continue

    echo "--------------------------------------"
    echo "Applying $(basename "$patch")"

    if patch -p1 --forward < "$patch"; then
        echo "[OK]"
    else
        echo "[ERROR] Failed: $(basename "$patch")"
        exit 1
    fi
done

echo "======================================"
echo " All patches applied successfully"
echo "======================================"
