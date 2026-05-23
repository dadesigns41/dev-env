# -----------------------------------------------------------------------------
# Script: install.sh
# Phase: Entry Point
# Requires: bash
# Behavior: Primary System Entry
# Notes: Runs 00-bootstrap then 01-foundation for full machine rebuild
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "=========================================="
echo " Ubuntu Dev Environment Installer"
echo "=========================================="

# Resolve repo root safely
REPO_ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

BOOTSTRAP_SCRIPT="$REPO_ROOT/00-bootstrap.sh"
FOUNDATION_SCRIPT="$REPO_ROOT/01-foundation.sh"

run_phase() {
  local script="$1"

  if [ -x "$script" ]; then
    echo ""
    echo "=========================================="
    echo " Running $(basename "$script")"
    echo "=========================================="
    "$script"
  else
    echo "[ERROR] Missing or non-executable script:"
    echo "        $script"
    exit 1
  fi
}

# -----------------------------------------
# SYSTEM INSTALL FLOW
# -----------------------------------------

run_phase "$BOOTSTRAP_SCRIPT"
run_phase "$FOUNDATION_SCRIPT"

echo ""
echo "=========================================="
echo " Ubuntu Dev Environment Complete"
echo "=========================================="
echo ""
echo "Recommended:"
echo "  • Reboot system if major packages changed"
echo "  • Run ./99-audit.sh to verify environment"