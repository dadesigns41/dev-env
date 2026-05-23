#!/usr/bin/env bash
set -e

# -----------------------------------------------------------------------------
# Script: 02-vscode.sh
# Phase: Install
# Requires: curl, wget, gpg, sudo
# Behavior: Idempotent
# Notes: Installs either VS Code or VSCodium based on configuration
# -----------------------------------------------------------------------------

echo "==> Installing code editor..."

# Choose editor: vscode | vscodium
EDITOR="${EDITOR:-vscode}"

install_vscode() {
  echo "==> Installing Visual Studio Code..."

  if dpkg -s code >/dev/null 2>&1; then
    echo "==> VS Code already installed, skipping..."
    return
  fi

  # Install dependencies
  sudo apt-get update
  sudo apt-get install -y wget gpg

  # Add Microsoft GPG key
  wget -qO- https://packages.microsoft.com/keys/microsoft.asc \
    | gpg --dearmor \
    | sudo tee /usr/share/keyrings/microsoft.gpg > /dev/null

  # Add repo
  echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] \
https://packages.microsoft.com/repos/code stable main" \
    | sudo tee /etc/apt/sources.list.d/vscode.list > /dev/null

  sudo apt-get update
  sudo apt-get install -y code

  echo "✅ VS Code installed"
}

install_vscodium() {
  echo "==> Installing VSCodium..."

  if dpkg -s codium >/dev/null 2>&1; then
    echo "==> VSCodium already installed, skipping..."
    return
  fi

  sudo apt-get update
  sudo apt-get install -y curl gpg

  # Add GPG key
  curl -fsSL https://gitlab.com/paulcarroty/vscodium-deb-rpm-repo/raw/master/pub.gpg \
    | gpg --dearmor \
    | sudo tee /usr/share/keyrings/vscodium.gpg > /dev/null

  # Add repo
  echo "deb [signed-by=/usr/share/keyrings/vscodium.gpg] \
https://download.vscodium.com/debs vscodium main" \
    | sudo tee /etc/apt/sources.list.d/vscodium.list > /dev/null

  sudo apt-get update
  sudo apt-get install -y codium

  echo "✅ VSCodium installed"
}

case "$EDITOR" in
  vscode)
    install_vscode
    ;;
  vscodium)
    install_vscodium
    ;;
  *)
    echo "❌ Unknown editor: $EDITOR (use vscode or vscodium)"
    exit 1
    ;;
esac

echo "🎉 Done."