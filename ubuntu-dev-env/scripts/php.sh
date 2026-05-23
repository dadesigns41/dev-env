# -----------------------------------------------------------------------------
# Script: php.sh
# Phase: Install
# Requires: sudo, apt
# Behavior: Idempotent
# Notes: Installs PHP CLI runtime
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "Installing PHP..."

if dpkg -s php >/dev/null 2>&1; then
  echo "[SKIP] PHP already installed"
else
  echo "[INSTALL] PHP"
  sudo apt update -y
  sudo apt install -y php php-cli
fi

echo "PHP install complete"