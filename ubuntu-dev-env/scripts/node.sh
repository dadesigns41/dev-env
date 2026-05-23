# -----------------------------------------------------------------------------
# Script: node.sh
# Phase: Install
# Requires: sudo, apt
# Behavior: Idempotent
# Notes: Installs Node.js and npm via APT
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "Installing Node.js..."

if dpkg -s nodejs npm >/dev/null 2>&1; then
  echo "[SKIP] Node.js already installed"
else
  echo "[INSTALL] Node.js + npm"
  sudo apt update -y
  sudo apt install -y nodejs npm
fi

echo "Node.js install complete"