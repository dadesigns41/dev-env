#!/usr/bin/env bash
# Uses env to locate bash via PATH for portability across systems (Ubuntu, WSL, Docker, minimal Linux distros)
set -e

# -----------------------------------------------------------------------------
# Script: 05-openwhispr.sh
# Phase: Install
# Requires: wget, tar, nohup
# Behavior: Idempotent
# Notes: Installs and launches OpenWhispr (Electron app) with --no-sandbox
# -----------------------------------------------------------------------------

APP_NAME="OpenWhispr"
APP_VERSION="1.7.0"
BASE_DIR="$HOME/Applications/$APP_NAME"
APP_DIR="$BASE_DIR/$APP_VERSION"
BINARY="$APP_DIR/open-whispr"
ARCHIVE="$BASE_DIR/$APP_NAME.tar.gz"
URL="https://github.com/openwhispr/openwhispr/releases/download/v$APP_VERSION/OpenWhispr-$APP_VERSION-linux-x64.tar.gz"

mkdir -p "$BASE_DIR"

# ---- INSTALL (idempotent section) ----
if [ ! -f "$BINARY" ]; then
    echo "OpenWhispr not found or broken. Installing clean copy..."

    # Clean previous partial installs
    rm -rf "$APP_DIR"
    rm -f "$ARCHIVE"

    cd "$BASE_DIR"

    echo "Downloading..."
    wget -O "$ARCHIVE" "$URL"

    echo "Extracting..."
    tar -xzf "$ARCHIVE"

    EXTRACTED_DIR=$(find . -maxdepth 1 -type d -name "OpenWhispr*" | head -n 1)
    mv "$EXTRACTED_DIR" "$APP_VERSION"

    chmod +x "$BINARY"

    echo "Install complete."
else
    echo "OpenWhispr already installed. Skipping install."
fi

# ---- RUN (always safe) ----
if [ ! -d "$APP_DIR" ]; then
    echo "Error: install directory missing"
    exit 1
fi

cd "$APP_DIR"

nohup ./open-whispr --no-sandbox >/dev/null 2>&1 &
echo "OpenWhispr launched."