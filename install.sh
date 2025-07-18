#!/bin/bash
set -e

REPO_URL="https://github.com/gouveags/my-ubuntu-autostart-config.git"
TEMP_DIR="/tmp/my-ubuntu-autostart-config"

cleanup_temp_files() {
  echo "🧹 Cleaning up temporary my-ubuntu-autostart-config files..."
  rm -rf "$TEMP_DIR"
}

cleanup_setup_artifacts() {
  echo "🧹 Cleaning up setup artifacts..."
  rm -f ~/.config/autostart/my-startup.desktop
  rm -f ~/.local/bin/my-ubuntu-autostartup
  rm -f ~/.local/bin/my-ubuntu-autostartup-uninstall
}

handle_error() {
  echo "❌ Installation failed!"
  cleanup_temp_files
  cleanup_setup_artifacts
  exit 1
}

trap handle_error ERR

echo "🔍 Checking system compatibility..."

if [[ "$(uname)" != "Linux" ]]; then
  echo "❌ This script only supports Linux."
  exit 1
fi

if ! command -v apt &> /dev/null; then
  echo "❌ Only apt-based systems are supported."
  exit 1
fi

echo "✅ Compatible system detected."

sudo apt update
sudo apt install -y git wmctrl

echo "📁 Cloning the repo..."
cleanup_temp_files
git clone "$REPO_URL" "$TEMP_DIR"

cd "$TEMP_DIR"

if [[ -f "setup.sh" ]]; then
  echo "⚙️  Running setup..."
  chmod +x ./setup.sh
  ./setup.sh
else
  echo "❌ Error: setup.sh not found in the repository."
  echo "Please ensure the repository contains the required setup.sh file."
  exit 1
fi

cleanup_temp_files
echo "✅ Done!"
