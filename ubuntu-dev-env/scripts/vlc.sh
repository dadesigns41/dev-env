# -----------------------------------------------------------------------------
# Script: vlc.sh
# Phase: Install
# Requires: sudo, apt
# Behavior: Idempotent
# Notes: Installs VLC media player via APT
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "Installing VLC..."

if dpkg -s vlc >/dev/null 2>&1; then
  echo "[SKIP] VLC already installed"
else
  echo "[INSTALL] VLC"
  sudo apt update -y
  sudo apt install -y vlc
fi

echo "VLC install complete"