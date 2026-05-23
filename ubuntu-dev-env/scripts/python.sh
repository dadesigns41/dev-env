# -----------------------------------------------------------------------------
# Script: python.sh
# Phase: Install
# Requires: sudo, apt
# Behavior: Idempotent
# Notes: Installs Python 3 and pip
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "Installing Python..."

if dpkg -s python3 python3-pip >/dev/null 2>&1; then
  echo "[SKIP] Python already installed"
else
  echo "[INSTALL] Python 3 + pip"
  sudo apt update -y
  sudo apt install -y python3 python3-pip
fi

echo "Python install complete"