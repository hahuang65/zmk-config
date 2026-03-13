#!/usr/bin/env bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
ZMK_INI_DIR="${HOME}/.config/zmk"
ZMK_INI="${ZMK_INI_DIR}/zmk.ini"

# Install zmk CLI
if ! command -v uv &>/dev/null; then
  echo "Error: uv is not installed. Install it from https://docs.astral.sh/uv/"
  exit 1
fi

echo "Installing zmk CLI..."
uv tool install zmk

# Write zmk.ini
echo "Writing ${ZMK_INI}..."
mkdir -p "${ZMK_INI_DIR}"
cat > "${ZMK_INI}" <<EOF
[user]
home = ${SCRIPT_DIR}

[core]
editor = nvim
EOF

# Initialize west workspace
echo "Initializing west workspace..."
cd "${SCRIPT_DIR}"
zmk west init -l config 2>/dev/null || true
zmk west update

echo "Done. Run 'zmk keyboard' to manage builds."
