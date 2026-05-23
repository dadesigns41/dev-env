# -----------------------------------------------------------------------------
# Script: 06-bitwarden.sh
# Phase: Install
# Requires: curl/wget, gpg, sudo
# Behavior: Idempotent
# Notes: Installs Bitwarden Desktop via official APT repository
# -----------------------------------------------------------------------------
#!/usr/bin/env bash

set -e

echo "Installing Bitwarden..."

# Check if Bitwarden is already installed
if dpkg -s bitwarden >/dev/null 2>&1; then
    echo "Bitwarden already installed. Skipping."
    exit 0
fi

# Create keyring directory if missing
sudo install -m 0755 -d /etc/apt/keyrings

# Add Bitwarden GPG key if missing
if [ ! -f /etc/apt/keyrings/bitwarden.gpg ]; then
    curl -fsSL https://downloads.bitwarden.com/linux/keys/bitwarden.asc \
        | gpg --dearmor \
        | sudo tee /etc/apt/keyrings/bitwarden.gpg > /dev/null
fi

# Add repository if missing
if [ ! -f /etc/apt/sources.list.d/bitwarden.list ]; then
    echo \
"deb [signed-by=/etc/apt/keyrings/bitwarden.gpg] https://downloads.bitwarden.com/linux/deb stable main" \
        | sudo tee /etc/apt/sources.list.d/bitwarden.list > /dev/null
fi

# Update package index
sudo apt update

# Install Bitwarden
sudo apt install -y bitwarden

echo "Bitwarden installation complete."