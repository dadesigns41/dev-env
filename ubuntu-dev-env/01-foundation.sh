# -----------------------------------------------------------------------------
# Script: 01-foundation.sh
# Phase: Install
# Requires: bash, sudo
# Behavior: System Orchestrator (no direct installs)
# Notes: Runs category layers in correct order
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "=== Ubuntu Dev Environment: Foundation Orchestrator ==="

# Resolve repo root (folder containing this script)
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Category scripts live at root level
CATEGORY_DIR="$REPO_ROOT"

run_category() {
  local script="$1"
  local path="$CATEGORY_DIR/$script"

  if [ -x "$path" ]; then
    echo ""
    echo ">>> Running category: $script"
    "$path"
  else
    echo "[SKIP] category not found or not executable: $path"
  fi
}

# -----------------------------
# SYSTEM ORDER (IMPORTANT)
# -----------------------------

run_category "02-desktop-apps.sh"
run_category "03-dev-runtime.sh"
run_category "04-infra-tools.sh"
run_category "05-optional.sh"

echo ""
echo "=== Foundation orchestration complete ==="