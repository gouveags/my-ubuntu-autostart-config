#!/bin/bash
set -e

# Function to clean up temporary files
cleanup_temp_files() {
  echo "🧹 Cleaning up temporary files..."
  rm -rf "/tmp/my-ubuntu-autostart-config"
}

# Function to clean up setup artifacts
cleanup_setup_artifacts() {
  echo "🧹 Cleaning up setup artifacts..."
  rm -f ~/.config/autostart/my-startup.desktop
  rm -f ~/.local/bin/my-ubuntu-autostartup
  rm -f ~/.local/bin/my-ubuntu-autostartup-uninstall
}

# Function to handle errors
handle_error() {
  echo "❌ Uninstall failed!"
  exit 1
}

# Set up error trap
trap handle_error ERR

echo "🗑️  Starting uninstall process..."

echo "🧹 Removing autostart configuration..."
cleanup_setup_artifacts

echo "🧹 Removing temporary files..."
cleanup_temp_files

echo "🗑️  Removing uninstall script..."
SCRIPT_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)/$(basename "${BASH_SOURCE[0]}")"
rm -f "$SCRIPT_PATH"

echo "✅ Uninstall complete! All autostart configurations have been removed."

echo "🎉 Uninstall process finished!"
