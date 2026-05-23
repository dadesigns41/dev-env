# -----------------------------------------------------------------------------
# Script: 05-optional.sh
# Phase: Install
# Requires: bash
# Behavior: Category Orchestrator (Optional Tools)
# Notes: Runs optional, non-essential utility installers
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "=== Optional Tools Orchestrator ==="

# Resolve repo root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Scripts directory
SCRIPTS_DIR="$REPO_ROOT/scripts"

run_tool() {
  local script="$1"
  local path="$SCRIPTS_DIR/$script"

  if [ -x "$path" ]; then
    echo ""
    echo ">>> Installing optional tool: $script"
    "$path"
  else
    echo "[SKIP] not found or not executable: $path"
  fi
}

# -----------------------------------------
# OPTIONAL TOOL ORDER
# -----------------------------------------

run_tool "flameshot.sh"     # screenshots / annotations
run_tool "gparted.sh"       # partition manager
run_tool "timeshift.sh"     # system snapshots
run_tool "rclone.sh"        # cloud/server sync
run_tool "tree.sh"          # terminal directory visualization

echo ""
echo "=== Optional Tools Complete ==="