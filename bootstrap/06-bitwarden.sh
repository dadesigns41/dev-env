# -----------------------------------------------------------------------------
# Script: 06-bitwarden.sh
# Phase: Install
# Requires: wget, sudo, apt
# Behavior: Idempotent
# Notes: Installs Bitwarden Desktop via official .deb installer (no APT repo)
# -----------------------------------------------------------------------------
#!/usr/bin/env bash

set -e

echo "Installing Bitwarden Desktop..."

# Check if already installed
if dpkg -s bitwarden >/dev/null 2>&1; then
    echo "Bitwarden already installed. Skipping."
    exit 0
fi

# Temp file location
DEB_FILE="/tmp/bitwarden.deb"

# Download latest .deb installer
echo "Downloading Bitwarden .deb..."
wget -q "https://bitwarden.com/download/?app=desktop&platform=linux&variant=deb" -O "$DEB_FILE"

# Install package via apt (handles dependencies properly)
echo "Installing Bitwarden..."
sudo apt install -y "$DEB_FILE"

# Cleanup
rm -f "$DEB_FILE"

echo "Bitwarden installation complete."