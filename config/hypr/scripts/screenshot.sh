#!/bin/bash
# Screenshot script for Hyprland using grim and slurp

SCREENSHOT_DIR="$HOME/Pictures/Screenshots"
TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")

# Create screenshots directory if it doesn't exist
mkdir -p "$SCREENSHOT_DIR"

# Function to send notification
notify_screenshot() {
    local file="$1"
    local action="$2"
    
    if command -v dunst >/dev/null 2>&1; then
        dunstify -i "$file" "Screenshot $action" "Saved to $(basename "$file")" -t 3000
    else
        echo "Screenshot $action: $file"
    fi
}

# Function to copy to clipboard
copy_to_clipboard() {
    local file="$1"
    if command -v wl-copy >/dev/null 2>&1; then
        wl-copy < "$file"
    fi
}

# Main screenshot logic
case "$1" in
    "full")
        filename="$SCREENSHOT_DIR/screenshot_$TIMESTAMP.png"
        grim "$filename"
        notify_screenshot "$filename" "taken"
        copy_to_clipboard "$filename"
        ;;
    "area")
        filename="$SCREENSHOT_DIR/screenshot_area_$TIMESTAMP.png"
        grim -g "$(slurp)" "$filename"
        notify_screenshot "$filename" "area captured"
        copy_to_clipboard "$filename"
        ;;
    "window")
        filename="$SCREENSHOT_DIR/screenshot_window_$TIMESTAMP.png"
        # Get the active window
        active_window=$(hyprctl activewindow -j | jq -r '"\(.at[0]),\(.at[1]) \(.size[0])x\(.size[1])"')
        grim -g "$active_window" "$filename"
        notify_screenshot "$filename" "window captured"
        copy_to_clipboard "$filename"
        ;;
    *)
        echo "Usage: $0 {full|area|window}"
        echo "  full   - Capture entire screen"
        echo "  area   - Capture selected area"
        echo "  window - Capture active window"
        exit 1
        ;;
esac