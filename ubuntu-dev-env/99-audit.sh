# -----------------------------------------------------------------------------
# Script: 99-audit.sh
# Phase: Verification
# Requires: bash
# Behavior: Read-only / Non-destructive
# Notes: Verifies expected development environment tools exist
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e

echo "=========================================="
echo " Ubuntu Dev Environment Audit"
echo "=========================================="

MISSING=0

check_command() {
  local name="$1"
  local command="$2"

  if command -v "$command" >/dev/null 2>&1; then
    echo "[PASS] $name"
  else
    echo "[FAIL] $name"
    ((MISSING++))
  fi
}

echo ""
echo "=== Desktop Applications ==="

check_command "Firefox Developer Edition" "firefox"
check_command "VS Code" "code"
check_command "OBS Studio" "obs"
check_command "VLC" "vlc"
check_command "DBeaver" "dbeaver"
check_command "Bitwarden" "bitwarden"

echo ""
echo "=== Development Runtime ==="

check_command "Python" "python3"
check_command "Pip" "pip3"
check_command "Node.js" "node"
check_command "npm" "npm"
check_command "PHP" "php"
check_command "Composer" "composer"

echo ""
echo "=== Infrastructure Tools ==="

check_command "Docker" "docker"
check_command "SSH Client" "ssh"
check_command "tmux" "tmux"
check_command "DNS Utils (dig)" "dig"
check_command "Net Tools (netstat)" "netstat"
check_command "Nmap" "nmap"

echo ""
echo "=== Optional Tools ==="

check_command "Flameshot" "flameshot"
check_command "GParted" "gparted"
check_command "Timeshift" "timeshift"
check_command "rclone" "rclone"
check_command "tree" "tree"

echo ""
echo "=========================================="

if [ "$MISSING" -eq 0 ]; then
  echo "[SUCCESS] Environment audit passed"
else
  echo "[WARNING] Missing tools detected: $MISSING"
fi

echo "=========================================="