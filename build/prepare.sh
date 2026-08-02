#!/usr/bin/env bash
set -euo pipefail

echo "======================================"
echo " Preparing build environment"
echo "======================================"

# Charger la configuration
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/env.sh"

echo "[INFO] Kernel repository : ${KERNEL_REPO}"
echo "[INFO] Branch            : ${KERNEL_BRANCH}"
echo "[INFO] Device            : ${DEVICE}"

# Cloner le noyau s'il n'existe pas
if [ ! -d "${KERNEL_PATH}" ]; then
    echo "[INFO] Cloning kernel source..."
    git clone \
        --depth=1 \
        --branch "${KERNEL_BRANCH}" \
        "${KERNEL_REPO}" \
        "${KERNEL_PATH}"
else
    echo "[INFO] Kernel source already present."
fi

# Vérification du defconfig
DEFCONFIG_PATH="${KERNEL_PATH}/arch/arm64/configs/vendor/${DEFCONFIG}"

if [ ! -f "${DEFCONFIG_PATH}" ]; then
    echo "[ERROR] Defconfig not found:"
    echo "        ${DEFCONFIG_PATH}"
    exit 1
fi

echo "[OK] Defconfig found."
