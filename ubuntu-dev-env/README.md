# Ubuntu Dev Environment

Reproducible Ubuntu development environment for development, infrastructure, self-hosting, and content creation.

---

# Philosophy

This environment prioritizes:

- Reproducibility
- APT-first package management
- Idempotent scripts
- Separation of concerns
- Easy machine rebuilds
- Production-minded local development

Install priority:

```text
APT
↓
Official APT Repository
↓
Docker
↓
Manual install (only if required)
```

---

# Script Naming & Header Convention

## File Naming

Prefix scripts with numbers to control execution order.

Examples:

```text
00-bootstrap.sh
01-firefox-dev.sh
02-docker.sh
```

Guidelines:

- Use short, descriptive names
- Use kebab-case
- Number scripts by execution order

---

## Header Format

Every script should follow the same header convention.

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

### Header Definitions

| Field | Purpose |
|--------|----------|
| `Script` | Script filename |
| `Phase` | Install / Configure / Cleanup |
| `Requires` | Dependencies needed before execution |
| `Behavior` | Idempotent, destructive, etc. |
| `Notes` | Important implementation details |

---

## Script Guidelines

Scripts should:

- Be idempotent (safe to re-run)
- Handle existing installs gracefully
- Stay focused on a single responsibility
- Follow execution order numbering
- Prefer APT installs where possible
- Avoid unnecessary complexity

---

# Environment Categories

## Bootstrap Utilities

Needed to make the machine usable and pull the dev environment repository.

| Program | Purpose |
|----------|----------|
| `git` | Pull dev-env repo first |
| `curl` | Install scripts / API requests |
| `wget` | Downloads |
| `ca-certificates` | SSL certificate trust store |
| `gnupg` | Repository signing keys |
| `software-properties-common` | Add/manage repositories |
| `build-essential` | Compiler/build toolchain |
| `xpad` | Sticky notes |
| `gzip` | Compression utility |
| `zip` | ZIP archive support |
| `unzip` | Extract ZIP archives |
| `p7zip-full` | 7z archive support |
| `unrar` | Extract RAR archives |
| `btop` | System resource monitor |
| `tree` | Visualize directory structure |
| `jq` | JSON parsing |
| `ripgrep` | Fast recursive code search (`rg`) |
| `fzf` | Terminal fuzzy finder |
| `ffmpeg` | Audio/video processing |
| `pavucontrol` | Audio device control |

Mapped Script:

```text
00-bootstrap.sh
```

---

## Foundational Tools

Daily-use applications and core development software.

| Program | Purpose |
|----------|----------|
| `vscode` | Primary code editor |
| `obs-studio` | Screen recording / content creation |
| `bitwarden` | Password manager |
| `docker` | Container runtime |
| `docker-compose` | Multi-container orchestration |
| `firefox-devedition` | Development browser |
| `dbeaver-ce` | Database GUI |
| `vlc` | Media player |
| `gnome-tweaks` | Ubuntu desktop customization |

Mapped Scripts:

```text
01-foundation.sh
02-desktop-apps.sh
```

---

## Dev / Runtime Tools

Useful local runtimes even when Docker handles most workloads.

| Program | Purpose |
|----------|----------|
| `python3` | Python runtime |
| `python3-pip` | Python package manager |
| `nodejs` | JavaScript runtime |
| `npm` | Node package manager |
| `php` | PHP runtime |
| `composer` | PHP package manager |

Mapped Script:

```text
03-dev-runtime.sh
```

---

## Infra / DevOps Tools

Useful for containers, networking, DNS, and self-hosted infrastructure.

| Program | Purpose |
|----------|----------|
| `openssh-client` | SSH into remote systems |
| `tmux` | Persistent terminal sessions |
| `dnsutils` | DNS tools (`dig`, `nslookup`) |
| `net-tools` | Network tools (`netstat`) |
| `nmap` | Network discovery / diagnostics |

Mapped Script:

```text
04-infra-tools.sh
```

---

## Optional Nice-to-Haves

| Program | Purpose |
|----------|----------|
| `filezilla` | Server file transfers |
| `rclone` | Cloud/server sync |
| `flameshot` | Screenshots / annotations |
| `gparted` | Disk partition manager |
| `timeshift` | System snapshots / rollback |

Mapped Script:

```text
05-optional.sh
```

---

# Install Order

```text
00-bootstrap
01-foundation
02-desktop-apps
03-dev-runtime
04-infra-tools
05-project-specific
99-post-install
```

---

# Usage

```bash
git clone <repo>
cd ubuntu-dev-environment
chmod +x install.sh
./install.sh
```

```bash
ubuntu-dev-environment/        # Root folder: entire reproducible system

├── install.sh                 # PRIMARY ENTRY POINT (ONLY real entry)
│                              # Think: "rebuild my machine from scratch"
│                              # Calls 00-bootstrap.sh then 01-foundation.sh

├── 00-bootstrap.sh           # Minimal survival layer
│                              # Installs only essentials to run system
│                              # Example: git, curl, wget, build tools
│                              # Used by install.sh ONLY

├── 01-foundation.sh          # SYSTEM ORCHESTRATOR (NOT an entry point)
│                              # Runs category layers in correct order:
│                              # 02-desktop-apps
│                              # 03-dev-runtime
│                              # 04-infra-tools
│                              # 05-optional
│
│                              # IMPORTANT: does NOT install tools directly

├── 02-desktop-apps.sh        # CATEGORY LAYER: GUI / daily apps
│                              # Groups desktop tools (browser, OBS, media)
│                              # Calls scripts/ (firefox, obs, vlc, etc.)

├── 03-dev-runtime.sh         # CATEGORY LAYER: programming runtimes
│                              # Node, Python, PHP, Composer, etc.

├── 04-infra-tools.sh         # CATEGORY LAYER: infrastructure tooling
│                              # SSH, tmux, nmap, dns tools, networking

├── 05-optional.sh            # CATEGORY LAYER: optional tools
│                              # filezilla, rclone, gparted, etc.

├── 99-audit.sh               # SYSTEM VERIFICATION (read-only layer)
│                              # Checks installed tools
│                              # Detects missing packages
│                              # Validates system state

│
├── scripts/                  # IMPLEMENTATION LAYER (single responsibility)
│                              # Each script installs ONE tool only
│
│   ├── firefox-dev.sh
│   ├── docker.sh
│   ├── vscode.sh
│   ├── obs.sh
│   ├── bitwarden.sh
│
│
├── lib/                      # SHARED LOGIC (reusable functions)
│                              # No execution here
│                              # Sourced by all scripts
│
│   └── common.sh             # install_if_missing, logging, helpers
│
│
├── config/                   # OPTIONAL FUTURE DECLARATIVE LAYER
│                              # Defines desired system state
│
│   ├── packages.json
│   ├── versions.lock
│
│
└── README.md                 # System documentation
                               # "How to rebuild my machine in 5 minutes"
└── README.md```