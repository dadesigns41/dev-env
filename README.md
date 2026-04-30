## Script Naming & Header Convention

### File Naming
- Prefix scripts with numbers to control order:
  - 00-clean.sh
  - 01-firefox-dev.sh
  - 02-docker.sh
- Use short, descriptive names (kebab-case)

### Header Format
```bash
# -----------------------------------------------------------------------------
# Script: 01-firefox-dev.sh
# Phase: Install
# Requires: curl/wget, gpg, sudo
# Behavior: Idempotent
# Notes: Runs alongside default Ubuntu Firefox (no removal required)
# -----------------------------------------------------------------------------
#!/usr/bin/env bash
set -e
```

### Guidelines
- Scripts should be idempotent (safe to re-run)
- Keep Behavior and Notes separate
- Use numbering to reflect execution order
- Keep it simple and consistent