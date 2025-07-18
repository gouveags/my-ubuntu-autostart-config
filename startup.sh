#!/bin/bash

# Delay the script to ensure the desktop environment is fully ready
sleep 10

# -----------------------------------------------------------------------------
# Function: launch_and_move
# Launches an application and moves its window to the specified workspace
#
# Arguments:
#   $1 - Command to launch the application (e.g., "code")
#   $2 - Substring to identify the window class (from wmctrl -lx)
#   $3 - Target workspace index (0-based, e.g., workspace 1 = 0)
# -----------------------------------------------------------------------------
launch_and_move() {
  cmd="$1"
  window_match="$2"
  workspace="$3"

  # Launch the application in the background
  eval "$cmd" &

  # Try to find the window for up to 10 seconds
  for i in {1..10}; do
    sleep 1
    # Get the window ID by matching against window class
    wid=$(wmctrl -lx | grep -i "$window_match" | awk '{print $1}' | head -n1)

    if [[ -n "$wid" ]]; then
      # Move the window to the desired workspace
      wmctrl -i -r "$wid" -t "$workspace"
      break
    fi
  done
}

# -----------------------------------------------------------------------------
# Function: maximize_window
# Maximizes the window vertically and horizontally
#
# Arguments:
#   $1 - Substring to identify the window class (from wmctrl -lx)
# -----------------------------------------------------------------------------
maximize_window() {
  window_match="$1"

  # Try to find the window again (in case it was not ready before)
  for i in {1..10}; do
    sleep 1
    wid=$(wmctrl -lx | grep -i "$window_match" | awk '{print $1}' | head -n1)

    if [[ -n "$wid" ]]; then
      # Maximize the window both vertically and horizontally
      wmctrl -i -r "$wid" -b add,maximized_vert,maximized_horz
      break
    fi
  done
}

# -----------------------------------------------------------------------------
# Launch and organize your apps below
# -----------------------------------------------------------------------------

# -----------------------------------------------------------------------------
# WORKSPACE 1 — Alacritty + Cursor
# -----------------------------------------------------------------------------

launch_and_move "alacritty" "alacritty.Alacritty" 0
maximize_window "alacritty.Alacritty"

launch_and_move "cursor" "cursor.Cursor" 0
maximize_window "cursor.Cursor"

# -----------------------------------------------------------------------------
# WORKSPACE 2 — Chrome
# -----------------------------------------------------------------------------

launch_and_move "google-chrome --restore-last-session" "google-chrome.Google-chrome" 1
maximize_window "google-chrome.Google-chrome"

# -----------------------------------------------------------------------------
# WORKSPACE 3 — Microsoft Teams (Web App via desktop entry)
# -----------------------------------------------------------------------------

launch_and_move "gtk-launch chrome-cifhbcnohmdccbgoicgdjpfamggdegmo-Default" "crx_cifhbcnohmdccbgoicgdjpfamggdegmo.Google-chrome" 2
maximize_window "crx_cifhbcnohmdccbgoicgdjpfamggdegmo.Google-chrome"

# -----------------------------------------------------------------------------
# WORKSPACE 4 — WhatsApp (Web App via desktop entry)
# -----------------------------------------------------------------------------

launch_and_move "gtk-launch WhatsApp" "web.whatsapp.com.Google-chrome" 3
maximize_window "web.whatsapp.com.Google-chrome"


# -----------------------------------------------------------------------------
# WORKSPACE 5 — Obsidian
# -----------------------------------------------------------------------------

launch_and_move "obsidian" "obsidian.obsidian" 4
maximize_window "obsidian.obsidian"

# -----------------------------------------------------------------------------
# WORKSPACE 6 — Spotify
# -----------------------------------------------------------------------------

launch_and_move "spotify" "spotify.Spotify" 5
maximize_window "spotify.Spotify"


