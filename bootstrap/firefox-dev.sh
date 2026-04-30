#!/usr/bin/env bash
set -e

echo "==> Installing Firefox Developer Edition..."

KEYRING="/etc/apt/keyrings/packages.mozilla.org.asc"
SOURCE="/etc/apt/sources.list.d/mozilla.list"
PREFS="/etc/apt/preferences.d/mozilla"

# Create keyrings dir
sudo install -d -m 0755 /etc/apt/keyrings

# Import key if missing
if [ ! -f "$KEYRING" ]; then
  echo "==> Importing Mozilla GPG key..."
  wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- \
    | sudo tee "$KEYRING" > /dev/null

  echo "==> Verifying key fingerprint..."
  FINGERPRINT=$(gpg -n -q --import --import-options import-show "$KEYRING" \
    | awk '/pub/{getline; gsub(/^ +| +$/,""); print $0}')

  EXPECTED="35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3"

  if [ "$FINGERPRINT" != "$EXPECTED" ]; then
    echo "❌ Fingerprint mismatch!"
    exit 1
  fi

  echo "✅ Key verified"
else
  echo "==> GPG key already exists, skipping..."
fi

# Add repo if missing
if [ ! -f "$SOURCE" ]; then
  echo "==> Adding Mozilla repo..."
  echo "deb [signed-by=$KEYRING] https://packages.mozilla.org/apt mozilla main" \
    | sudo tee "$SOURCE" > /dev/null
else
  echo "==> Repo already exists, skipping..."
fi

# Add pinning if missing
if [ ! -f "$PREFS" ]; then
  echo "==> Setting repo priority..."
  cat <<EOF | sudo tee "$PREFS"
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
EOF
else
  echo "==> Pinning already exists, skipping..."
fi

# Update only if repo was just added
echo "==> Updating APT..."
sudo apt-get update

# Install only if not installed
if ! dpkg -s firefox-devedition >/dev/null 2>&1; then
  echo "==> Installing Firefox Developer Edition..."
  sudo apt-get install -y firefox-devedition
else
  echo "==> Firefox Developer Edition already installed, skipping..."
fi

echo "🎉 Done."