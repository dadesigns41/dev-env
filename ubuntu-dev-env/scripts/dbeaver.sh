# -----------------------------------------------------------------------------
# Script: dbeaver.sh
# Phase: Install
# Requires: sudo, apt
# Behavior: Idempotent
# Notes: Installs DBeaver Community Edition via APT
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "Installing DBeaver Community Edition..."

if dpkg -s dbeaver-ce >/dev/null 2>&1; then
  echo "[SKIP] DBeaver already installed"
else
  echo "[INSTALL] DBeaver Community Edition"
  sudo apt update -y
  sudo apt install -y dbeaver-ce
fi

echo "DBeaver install complete"