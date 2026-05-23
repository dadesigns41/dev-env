# -----------------------------------------------------------------------------
# Script: 03-dev-runtime.sh
# Phase: Install
# Requires: bash
# Behavior: Category Orchestrator (Development Runtimes)
# Notes: Runs development runtime installers in defined order
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "=== Development Runtime Orchestrator ==="

# Resolve repo root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Scripts directory
SCRIPTS_DIR="$REPO_ROOT/scripts"

run_tool() {
  local script="$1"
  local path="$SCRIPTS_DIR/$script"

  if [ -x "$path" ]; then
    echo ""
    echo ">>> Installing runtime: $script"
    "$path"
  else
    echo "[SKIP] not found or not executable: $path"
  fi
}

# -----------------------------------------
# DEVELOPMENT RUNTIME ORDER
# -----------------------------------------

run_tool "python.sh"
run_tool "node.sh"
run_tool "php.sh"
run_tool "composer.sh"

echo ""
echo "=== Development Runtime Complete ==="