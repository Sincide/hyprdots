# Waybar Troubleshooting Guide

## Quick Fixes

### 1. Manual Start
If Waybar doesn't start automatically:
```bash
# Kill any existing instances
pkill waybar

# Start manually
waybar
```

### 2. Check if Waybar is installed
```bash
which waybar
# Should return: /usr/bin/waybar
```

If not installed:
```bash
sudo pacman -S waybar
```

### 3. Test Configuration Syntax
```bash
# Test with minimal config
waybar --config ~/.config/waybar/config-minimal --style ~/.config/waybar/style.css
```

### 4. Check Dependencies
Ensure these packages are installed:
```bash
sudo pacman -S waybar hyprland playerctl pavucontrol
```

## Common Issues

### Issue: Waybar starts but no bars visible
**Cause**: Module dependencies missing or module errors
**Solution**: 
1. Use the minimal config: `waybar --config ~/.config/waybar/config-minimal`
2. Check logs: `waybar 2>&1 | head -20`

### Issue: "No Hyprland socket found"
**Cause**: Not running under Hyprland
**Solution**: Only start Waybar after Hyprland is running

### Issue: Modules not working
**Cause**: Missing dependencies for specific modules

**For audio module (pulseaudio)**:
```bash
sudo pacman -S pipewire pipewire-pulse pavucontrol
```

**For media module (custom/media)**:
```bash
sudo pacman -S playerctl
```

**For network module**:
```bash
sudo pacman -S networkmanager
```

### Issue: Permission denied errors
**Cause**: Config files not accessible
**Solution**:
```bash
chmod 644 ~/.config/waybar/config
chmod 644 ~/.config/waybar/style.css
```

## Module-Specific Troubleshooting

### Hyprland Workspaces Not Showing
1. Check if running under Hyprland: `echo $XDG_CURRENT_DESKTOP`
2. Verify Hyprland socket: `ls /tmp/hypr/`

### Audio Module Not Working
1. Test audio system: `wpctl status`
2. Check PulseAudio: `pactl info`
3. Install missing audio packages

### Network Module Issues
1. Check NetworkManager: `systemctl status NetworkManager`
2. Enable if needed: `sudo systemctl enable --now NetworkManager`

## Safe Configuration

If main config fails, use this minimal working config:

### Minimal ~/.config/waybar/config:
```json
{
    "layer": "top",
    "position": "top",
    "height": 40,
    "modules-left": ["hyprland/workspaces"],
    "modules-center": ["hyprland/window"],
    "modules-right": ["clock"],
    
    "hyprland/workspaces": {
        "format": "{name}"
    },
    
    "hyprland/window": {
        "format": "{}"
    },
    
    "clock": {
        "format": "{:%H:%M}"
    }
}
```

## Manual Restart Commands

### Restart Waybar
```bash
# Use Super+Alt+R (configured keybinding)
# Or manually:
pkill waybar && waybar &
```

### Debug Mode
```bash
waybar --log-level debug
```

### Reset to Minimal Config
```bash
cp ~/.config/waybar/config-minimal ~/.config/waybar/config
```

## Package Installation Issues

If packages are missing during setup:
```bash
# Update package database
sudo pacman -Sy

# Install Waybar and dependencies
sudo pacman -S waybar hyprland-git kitty firefox dunst fuzzel

# Install audio support
sudo pacman -S pipewire pipewire-pulse pavucontrol

# Install media control
sudo pacman -S playerctl

# Install network management
sudo pacman -S networkmanager nm-connection-editor
```

## Final Notes

- The main config has dual bars (top and bottom)
- The minimal config has only a top bar
- Hardware-specific modules (battery, backlight, temperature) have been removed from the main config to prevent startup failures
- All module commands include fallbacks to prevent crashes