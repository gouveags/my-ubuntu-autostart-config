#!/bin/bash
set -e

echo "🔧 Setting up autostart..."

if [[ ! -f "./autostart.desktop.template" ]]; then
  echo "❌ Error: autostart.desktop.template not found in current directory"
  exit 1
fi

if [[ ! -f "./startup.sh" ]]; then
  echo "❌ Error: startup.sh not found in current directory"
  exit 1
fi

echo "Creating autostart directory..."
if ! mkdir -p ~/.config/autostart; then
  echo "❌ Error: Failed to create autostart directory"
  exit 1
fi

echo "Copying autostart file..."
if ! cp ./autostart.desktop.template ~/.config/autostart/my-startup.desktop; then
  echo "❌ Error: Failed to copy autostart.desktop.template"
  exit 1
fi

echo "Setting permissions on autostart file..."
if ! chmod +x ~/.config/autostart/my-startup.desktop; then
  echo "❌ Error: Failed to set permissions on autostart file"
  exit 1
fi

echo "Creating local bin directory..."
if ! mkdir -p ~/.local/bin; then
  echo "❌ Error: Failed to create ~/.local/bin directory"
  exit 1
fi

echo "Copying startup script to permanent location..."
if ! cp ./startup.sh ~/.local/bin/my-ubuntu-autostartup; then
  echo "❌ Error: Failed to copy startup script to ~/.local/bin"
  exit 1
fi

echo "Making startup script executable..."
if ! chmod +x ~/.local/bin/my-ubuntu-autostartup; then
  echo "❌ Error: Failed to make startup script executable"
  exit 1
fi

echo "Setting up uninstall script..."
if ! cp ./uninstall.sh ~/.local/bin/my-ubuntu-autostartup-uninstall; then
  echo "❌ Error: Failed to copy uninstall script to ~/.local/bin"
  exit 1
fi

if ! chmod +x ~/.local/bin/my-ubuntu-autostartup-uninstall; then
  echo "❌ Error: Failed to make uninstall script executable"
  exit 1
fi

echo "✅ Setup complete. Apps will auto-launch on next reboot."
