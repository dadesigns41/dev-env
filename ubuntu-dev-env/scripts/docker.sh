#!/usr/bin/env bash
set -e

# -----------------------------------------------------------------------------
# Script: 04-docker.sh
# Phase: Install
# Requires: curl, sudo
# Behavior: Idempotent
# Notes: Installs Docker Engine + Compose plugin for development environment
# -----------------------------------------------------------------------------

echo "==> Removing old Docker versions (if any)..."
sudo apt remove -y docker docker-engine docker.io containerd runc 2>/dev/null || true

echo "==> Installing dependencies..."
sudo apt update
sudo apt install -y ca-certificates curl gnupg

echo "==> Setting up Docker GPG key..."
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg

echo "==> Adding Docker repository..."
echo \
  "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

echo "==> Installing Docker Engine + Compose..."
sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

echo "==> Enabling Docker service..."
sudo systemctl enable docker
sudo systemctl start docker

echo "==> Adding current user to docker group..."
sudo usermod -aG docker "$USER"

echo "==> Verifying Docker installation..."
if command -v docker >/dev/null 2>&1; then
    echo "✔ Docker installed:"
    docker --version
else
    echo "✖ Docker installation failed"
    exit 1
fi

echo "==> Verifying Docker Compose..."
if docker compose version >/dev/null 2>&1; then
    echo "✔ Docker Compose available"
else
    echo "⚠ Docker Compose not available"
fi

echo ""
echo "===================================="
echo " Docker setup complete"
echo "===================================="
echo "IMPORTANT: Log out and back in for docker group changes to apply"