#!/usr/bin/env bash
set -e

# -----------------------------------------------------------------------------
# Script: 03-obs-studio.sh
# Phase: Install
# Requires: curl, wget, gpg, sudo, ffmpeg
# Behavior: Idempotent
# Notes: Installs OBS Studio with NVIDIA/NVENC support utilities for screencasts
#        Optimized for dev screen rec on matebook x pro.
# -----------------------------------------------------------------------------

echo "==> Updating package lists..."
sudo apt update

echo "==> Installing OBS Studio..."
sudo apt install -y obs-studio

echo "==> Installing recording + multimedia dependencies..."
sudo apt install -y ffmpeg v4l-utils vainfo

echo "==> Installing audio control tools..."
sudo apt install -y pavucontrol pulseaudio-utils

echo "==> Checking for NVIDIA driver..."
if command -v nvidia-smi >/dev/null 2>&1; then
    echo "✔ NVIDIA detected:"
    nvidia-smi --query-gpu=name,driver_version --format=csv,noheader
else
    echo "⚠ NVIDIA driver not detected (NVENC may not be available)"
fi

echo "==> Checking FFmpeg NVENC support..."
if ffmpeg -hide_banner -encoders 2>/dev/null | grep -q nvenc; then
    echo "✔ NVENC encoder available"
else
    echo "⚠ NVENC not found in FFmpeg build (CPU encoding will be used)"
fi

echo "==> Verifying OBS installation..."
if command -v obs >/dev/null 2>&1; then
    echo "✔ OBS Studio installed successfully"
    obs --version
else
    echo "✖ OBS installation failed"
    exit 1
fi

echo "==> Setup complete"
echo "Next steps:"
echo "  - Use 'Ubuntu on Xorg' session for best compatibility"
echo "  - Set OBS encoder to NVENC (if available)"
echo "  - Record at 1080p30 for clean developer screencasts"