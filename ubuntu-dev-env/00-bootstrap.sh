# -----------------------------------------------------------------------------
# Script: 00-bootstrap.sh
# Phase: Install
# Requires: sudo, apt
# Behavior: Idempotent
# Notes: Core bootstrap utilities required to clone repo and run environment
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "=== Ubuntu Dev Environment: Bootstrap Install ==="

PACKAGES=(
  git
  curl
  wget
  ca-certificates
  gnupg
  software-properties-common
  build-essential

  xpad
  gzip
  zip
  unzip
  p7zip-full
  unrar

  btop
  tree
  jq
  ripgrep
  fzf

  ffmpeg
  pavucontrol
)

echo "Updating APT package index..."
sudo apt update -y

echo "Installing bootstrap packages..."

for pkg in "${PACKAGES[@]}"; do
  if dpkg -s "$pkg" >/dev/null 2>&1; then
    echo "[SKIP] $pkg already installed"
  else
    echo "[INSTALL] $pkg"
    sudo apt install -y "$pkg"
  fi
done

echo "Cleaning up..."
sudo apt autoremove -y
sudo apt clean

echo "=== Bootstrap complete ==="