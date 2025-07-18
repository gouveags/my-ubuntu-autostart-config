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

is_package_installed() {
  local package_name="$1"
  dpkg -l "$package_name" 2>/dev/null | grep -q "^ii"
}

is_command_available() {
  local command_name="$1"
  command -v "$command_name" >/dev/null 2>&1
}

install_if_missing() {
  local package_name="$1"
  local display_name="${2:-$package_name}"

  if is_package_installed "$package_name"; then
    echo "✅ $display_name is already installed"
  else
    echo "📦 Installing $display_name..."
    sudo apt-get install -y "$package_name" >/dev/null
    echo "✅ $display_name installed successfully"
  fi
}

check_application() {
  local app_name="$1"
  local display_name="${2:-$app_name}"

  if is_command_available "$app_name"; then
    echo "✅ $display_name is available"
  else
    echo "⚠️  $display_name is not found - you may need to install it manually"
  fi
}

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

echo "🔄 Updating package lists..."
sudo apt-get update >/dev/null

echo "📦 Checking and installing required packages..."

if is_command_available "git"; then
  echo "✅ Git is already installed"
else
  echo "📦 Installing Git..."
  sudo apt-get install -y git >/dev/null
  echo "✅ Git installed successfully"
fi

install_if_missing "wmctrl" "Window Manager Control"

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
