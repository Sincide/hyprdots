#!/bin/bash
# Wallpaper management script for Hyprland

WALLPAPER_DIR="$HOME/Pictures/wallpapers"
CONFIG_FILE="$HOME/.config/hypr/hyprpaper.conf"

# Function to set random wallpaper
set_random_wallpaper() {
    if [[ ! -d "$WALLPAPER_DIR" ]]; then
        echo "Wallpaper directory not found: $WALLPAPER_DIR"
        exit 1
    fi
    
    # Find all image files
    mapfile -t wallpapers < <(find "$WALLPAPER_DIR" -type f \( -iname "*.jpg" -o -iname "*.jpeg" -o -iname "*.png" -o -iname "*.webp" \) 2>/dev/null)
    
    if [[ ${#wallpapers[@]} -eq 0 ]]; then
        echo "No wallpapers found in $WALLPAPER_DIR"
        exit 1
    fi
    
    # Select random wallpaper
    selected_wallpaper="${wallpapers[RANDOM % ${#wallpapers[@]}]}"
    
    # Update hyprpaper config
    sed -i "s|wallpaper = .*|wallpaper = ,${selected_wallpaper}|g" "$CONFIG_FILE"
    
    # Reload hyprpaper
    pkill hyprpaper
    hyprpaper &
    
    echo "Set wallpaper: $(basename "$selected_wallpaper")"
}

# Function to set specific wallpaper
set_wallpaper() {
    local wallpaper_path="$1"
    
    if [[ ! -f "$wallpaper_path" ]]; then
        echo "Wallpaper file not found: $wallpaper_path"
        exit 1
    fi
    
    # Update hyprpaper config
    sed -i "s|wallpaper = .*|wallpaper = ,${wallpaper_path}|g" "$CONFIG_FILE"
    
    # Reload hyprpaper
    pkill hyprpaper
    hyprpaper &
    
    echo "Set wallpaper: $(basename "$wallpaper_path")"
}

# Main logic
case "$1" in
    "random")
        set_random_wallpaper
        ;;
    "set")
        if [[ -n "$2" ]]; then
            set_wallpaper "$2"
        else
            echo "Usage: $0 set <wallpaper_path>"
            exit 1
        fi
        ;;
    *)
        echo "Usage: $0 {random|set <wallpaper_path>}"
        echo "Examples:"
        echo "  $0 random                    # Set random wallpaper"
        echo "  $0 set ~/Pictures/wall.jpg   # Set specific wallpaper"
        exit 1
        ;;
esac