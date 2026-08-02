#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

echo "======================================"
echo "      Copilote Build System v2"
echo "======================================"

source "${SCRIPT_DIR}/env.sh"

chmod +x "${SCRIPT_DIR}/prepare.sh"
chmod +x "${SCRIPT_DIR}/patch.sh"
chmod +x "${SCRIPT_DIR}/compile.sh"
chmod +x "${SCRIPT_DIR}/package.sh"

echo "[1/4] Preparing environment..."
"${SCRIPT_DIR}/prepare.sh"

echo "[2/4] Applying patches..."
"${SCRIPT_DIR}/patch.sh"

echo "[3/4] Compiling kernel..."
"${SCRIPT_DIR}/compile.sh"

echo "[4/4] Packaging..."
"${SCRIPT_DIR}/package.sh"

echo "======================================"
echo " Build completed successfully!"
echo "======================================"
