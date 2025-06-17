# Available Waybar Modules

## Core System Modules
- **hyprland/workspaces** - Shows workspace buttons/indicators
- **hyprland/window** - Displays current window title
- **hyprland/mode** - Shows current Hyprland mode (if any)
- **clock** - Date and time display
- **tray** - System tray icons

## Hardware Monitoring
- **cpu** - CPU usage percentage
- **memory** - RAM usage
- **disk** - Disk usage for specified path
- **temperature** - CPU/system temperature (if sensors available)
- **network** - Network connection status and info

## Audio & Media
- **pulseaudio** - Volume control and audio device info
- **custom/media** - Media player info (requires playerctl)

## System Control
- **idle_inhibitor** - Prevent system sleep toggle
- **bluetooth** - Bluetooth status and control

## Custom Modules
- **custom/updates** - Package update count
- **custom/power** - Power/logout button
- **custom/weather** - Weather info (requires internet)
- **custom/logo** - Clickable logo/launcher button

## Currently NOT Available (Hardware Dependent)
- **battery** - Battery status (no battery hardware)
- **backlight** - Screen brightness (no backlight hardware)

## Package Dependencies
Some modules require specific packages:
- **pulseaudio**: pipewire, pipewire-pulse, pavucontrol
- **custom/media**: playerctl
- **bluetooth**: bluez, bluez-utils, blueman
- **network**: networkmanager
- **custom/updates**: pacman
- **temperature**: lm_sensors (if supported)