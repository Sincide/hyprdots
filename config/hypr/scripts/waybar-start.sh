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

# Try to start waybar with main config first
echo "Starting Waybar with main configuration..."
waybar > /tmp/waybar.log 2>&1 &
WAYBAR_PID=$!

# Check if waybar started successfully
sleep 3
if pgrep waybar >/dev/null; then
    echo "Waybar started successfully with main config"
    exit 0
fi

# If main config failed, try minimal config
echo "Main config failed, trying minimal configuration..."
kill $WAYBAR_PID 2>/dev/null || true
pkill waybar 2>/dev/null || true
sleep 1

# Start with minimal config
waybar --config "$HOME/.config/waybar/config-minimal" --style "$HOME/.config/waybar/style.css" > /tmp/waybar-minimal.log 2>&1 &

sleep 3
if pgrep waybar >/dev/null; then
    echo "Waybar started with minimal configuration"
    notify-send "Waybar" "Started with minimal configuration" 2>/dev/null || true
else
    echo "Failed to start Waybar even with minimal config"
    echo "Main config log:"
    cat /tmp/waybar.log 2>/dev/null || echo "No main log found"
    echo "Minimal config log:"
    cat /tmp/waybar-minimal.log 2>/dev/null || echo "No minimal log found"
    notify-send "Waybar Error" "Failed to start with any configuration" 2>/dev/null || true
    exit 1
fi