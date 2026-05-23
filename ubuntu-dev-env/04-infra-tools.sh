# -----------------------------------------------------------------------------
# Script: 04-infra-tools.sh
# Phase: Install
# Requires: bash
# Behavior: Category Orchestrator (Infrastructure Tools)
# Notes: Runs infrastructure and systems tooling installers
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "=== Infrastructure Tools Orchestrator ==="

# Resolve repo root
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Scripts directory
SCRIPTS_DIR="$REPO_ROOT/scripts"

run_tool() {
  local script="$1"
  local path="$SCRIPTS_DIR/$script"

  if [ -x "$path" ]; then
    echo ""
    echo ">>> Installing infrastructure tool: $script"
    "$path"
  else
    echo "[SKIP] not found or not executable: $path"
  fi
}

# -----------------------------------------
# INFRASTRUCTURE TOOL ORDER
# -----------------------------------------

run_tool "docker.sh"

run_tool "openssh-client.sh"
run_tool "tmux.sh"

run_tool "dnsutils.sh"
run_tool "net-tools.sh"
run_tool "nmap.sh"

echo ""
echo "=== Infrastructure Tools Complete ==="