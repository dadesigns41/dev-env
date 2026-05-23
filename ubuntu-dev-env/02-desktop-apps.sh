# -----------------------------------------------------------------------------
# Script: 02-desktop-apps.sh
# Phase: Install
# Requires: bash
# Behavior: Category Orchestrator (GUI / Desktop Apps)
# Notes: Runs all desktop-related tool installers in defined order
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "=== Desktop Apps Orchestrator ==="

# Resolve repo root (location of this script)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SCRIPTS_DIR="$REPO_ROOT/scripts"

run_tool() {
  local script="$1"
  local path="$SCRIPTS_DIR/$script"

  if [ -x "$path" ]; then
    echo ""
    echo ">>> Installing desktop tool: $script"
    "$path"
  else
    echo "[SKIP] not found or not executable: $path"
  fi
}

# -----------------------------
# DESKTOP APPLICATION ORDER
# -----------------------------

run_tool "bitwarden.sh"
run_tool "dbeaver.sh"
run_tool "docker.sh"
run_tool "firefox-dev.sh"
run_tool "gnome-tweaks.sh"
run_tool "obs-studio.sh"
run_tool "openwhispr.sh"
run_tool "vlc.sh"
run_tool "vscode.sh"

echo ""
echo "=== Desktop Apps complete ==="