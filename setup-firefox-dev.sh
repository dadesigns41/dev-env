#!/usr/bin/env bash
set -e

echo "==> Setting up Mozilla APT repo..."

# Create keyrings dir
sudo install -d -m 0755 /etc/apt/keyrings

# Import key (only if not exists)
if [ ! -f /etc/apt/keyrings/packages.mozilla.org.asc ]; then
  wget -q https://packages.mozilla.org/apt/repo-signing-key.gpg -O- \
    | sudo tee /etc/apt/keyrings/packages.mozilla.org.asc > /dev/null
fi

# Verify fingerprint
echo "==> Verifying key fingerprint..."
FINGERPRINT=$(gpg -n -q --import --import-options import-show /etc/apt/keyrings/packages.mozilla.org.asc \
  | awk '/pub/{getline; gsub(/^ +| +$/,""); print $0}')

EXPECTED="35BAA0B33E9EB396F59CA838C0BA5CE6DC6315A3"

if [ "$FINGERPRINT" != "$EXPECTED" ]; then
  echo "❌ Fingerprint mismatch!"
  exit 1
fi

echo "✅ Fingerprint verified"

# Add repo (only if not exists)
if [ ! -f /etc/apt/sources.list.d/mozilla.list ]; then
  echo "==> Adding Mozilla repo..."
  echo "deb [signed-by=/etc/apt/keyrings/packages.mozilla.org.asc] https://packages.mozilla.org/apt mozilla main" \
    | sudo tee /etc/apt/sources.list.d/mozilla.list > /dev/null
fi

# Add pinning
if [ ! -f /etc/apt/preferences.d/mozilla ]; then
  echo "==> Setting repo priority..."
  cat <<EOF | sudo tee /etc/apt/preferences.d/mozilla
Package: *
Pin: origin packages.mozilla.org
Pin-Priority: 1000
EOF
fi

echo "==> Updating APT..."
sudo apt-get update

echo "==> Installing Firefox Developer Edition..."
sudo apt-get install -y firefox-devedition

echo "🎉 Done."