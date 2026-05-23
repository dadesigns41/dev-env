# -----------------------------------------------------------------------------
# Script: gnome-tweaks.sh
# Phase: Install
# Requires: sudo, apt
# Behavior: Idempotent
# Notes: Installs GNOME Tweaks for desktop customization
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "Installing GNOME Tweaks..."

if dpkg -s gnome-tweaks >/dev/null 2>&1; then
  echo "[SKIP] GNOME Tweaks already installed"
else
  echo "[INSTALL] GNOME Tweaks"
  sudo apt update -y
  sudo apt install -y gnome-tweaks
fi

echo "GNOME Tweaks install complete"