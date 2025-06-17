#!/bin/bash
# Waybar startup script with error handling

# Kill any existing waybar instances
pkill waybar

# Wait a moment for processes to fully terminate
sleep 1

# Check if waybar is installed
if ! command -v waybar >/dev/null 2>&1; then
    echo "Waybar is not installed"
    notify-send "Waybar Error" "Waybar is not installed" 2>/dev/null || true
    exit 1
fi

# Check if config files exist
CONFIG_FILE="$HOME/.config/waybar/config"
STYLE_FILE="$HOME/.config/waybar/style.css"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo "Waybar config file not found: $CONFIG_FILE"
    notify-send "Waybar Error" "Config file not found" 2>/dev/null || true
    exit 1
fi

if [[ ! -f "$STYLE_FILE" ]]; then
    echo "Waybar style file not found: $STYLE_FILE"
    notify-send "Waybar Error" "Style file not found" 2>/dev/null || true
    exit 1
fi

# Start waybar with error logging
echo "Starting Waybar..."
waybar > /tmp/waybar.log 2>&1 &

# Check if waybar started successfully
sleep 2
if pgrep waybar >/dev/null; then
    echo "Waybar started successfully"
else
    echo "Failed to start Waybar. Check log: /tmp/waybar.log"
    notify-send "Waybar Error" "Failed to start. Check /tmp/waybar.log" 2>/dev/null || true
    exit 1
fi