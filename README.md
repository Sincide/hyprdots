# Arch Linux Hyprland Post-Install Script

A comprehensive post-installation script for setting up a complete Hyprland desktop environment on Arch Linux with fish shell, dual waybars, and dotfile management.

## Features

### Core Components
- **Hyprland**: Modern Wayland compositor with beautiful animations
- **Kitty**: Fast, GPU-accelerated terminal emulator
- **Fish Shell**: User-friendly shell with syntax highlighting and autocompletion
- **Waybar**: Highly customizable dual status bars (top and bottom)
- **Fuzzel**: Fast application launcher
- **Dunst**: Lightweight notification daemon
- **Hyprpaper**: Wallpaper manager for Hyprland

### Applications Installed
- **System**: btop, fastfetch, nano, thunar, firefox
- **Audio**: pipewire, pipewire-pulse, pavucontrol
- **Network**: network-manager-applet, bluez, blueman
- **Utilities**: grim, slurp, wl-clipboard, brightnessctl, playerctl
- **AUR Helper**: yay-bin for package management

### Configuration Management
- Automatic symlink creation from `config/` to `~/.config/`
- Backup of existing configurations
- Modular configuration files for all applications
- Custom fish shell prompt and aliases
- Comprehensive keybinding setup

## Installation

1. **Clone the repository:**
   ```bash
   git clone <repository-url>
   cd arch-hyprland-setup
   ```

2. **Make the script executable:**
   ```bash
   chmod +x install.sh
   ```

3. **Run the installation:**
   ```bash
   ./install.sh
   