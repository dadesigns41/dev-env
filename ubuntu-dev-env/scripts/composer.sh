# -----------------------------------------------------------------------------
# Script: composer.sh
# Phase: Install
# Requires: sudo, apt, php
# Behavior: Idempotent
# Notes: Installs Composer package manager
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "Installing Composer..."

if dpkg -s composer >/dev/null 2>&1; then
  echo "[SKIP] Composer already installed"
else
  echo "[INSTALL] Composer"
  sudo apt update -y
  sudo apt install -y composer
fi

echo "Composer install complete"