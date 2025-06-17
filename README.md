# Arch Linux Hyprland Setup

A comprehensive post-install script for Arch Linux featuring Hyprland window manager, Fish shell, dual Waybar configuration, and complete dark theme integration.

## Features

- **Modern Wayland Desktop**: Hyprland compositor with advanced animations and effects
- **Fish Shell**: Intelligent shell with Catppuccin Mocha color scheme and custom prompt
- **Dual Waybar Configuration**: Top and bottom status bars with comprehensive system monitoring
- **Complete Dark Theming**: Consistent dark theme across GTK, Qt, and all applications
- **Modular Configuration**: Organized, maintainable configuration files
- **Smart Symlink Management**: Repository-based configuration with automatic backups
- **Custom Scripts**: Wallpaper management and enhanced screenshot functionality

## Quick Start

1. **Clone the repository:**
```bash
git clone <your-repo-url> ~/hyprdots
cd ~/hyprdots
```

2. **Run the installation:**
```bash
chmod +x install.sh
./install.sh
```

3. **Reboot and select Hyprland** from your display manager, or start with `Hyprland` command.

## What Gets Installed

### Core Desktop Environment
- **Hyprland** - Tiling Wayland compositor
- **Hyprpaper** - Wallpaper manager
- **Waybar** - Status bar with dual configuration
- **Fuzzel** - Application launcher
- **Dunst** - Notification daemon
- **Kitty** - GPU-accelerated terminal

### Applications
- **Firefox** - Web browser with Wayland support
- **Thunar** - File manager with thumbnails
- **Nano** - Text editor with syntax highlighting
- **MPV** - Media player
- **Imv** - Image viewer

### System Components
- **Pipewire** - Modern audio system
- **Bluetooth** - Full Bluetooth stack
- **NetworkManager** - Network management
- **Polkit** - Authentication framework

### Themes & Fonts
- **Papirus Dark** - Icon theme
- **Bibata Modern Classic** - Cursor theme
- **JetBrains Mono** - Primary font
- **Noto Fonts** - System fonts with emoji support
- **Catppuccin Mocha** - Color scheme

### Development Tools
- **Fish** - Modern shell with intelligent autocompletion
- **Btop** - System monitor
- **Fastfetch** - System information
- **Git** - Version control

## Key Bindings

### Window Management
| Binding | Action |
|---------|--------|
| `Super + Return` | Open terminal |
| `Super + Q` | Close window |
| `Super + F` | Toggle fullscreen |
| `Super + V` | Toggle floating |
| `Super + P` | Toggle pseudo-tiling |
| `Super + J/K` | Focus next/previous window |
| `Super + H/L` | Resize window |

### Applications
| Binding | Action |
|---------|--------|
| `Super + D` | Application launcher |
| `Super + E` | File manager |
| `Super + Shift + E` | Exit Hyprland |

### Workspaces
| Binding | Action |
|---------|--------|
| `Super + 1-9` | Switch to workspace |
| `Super + Shift + 1-9` | Move window to workspace |
| `Super + Alt + 1-9` | Move window silently |
| `Super + S` | Toggle scratchpad |
| `Super + Mouse Wheel` | Scroll workspaces |

### Screenshots
| Binding | Action |
|---------|--------|
| `Print` | Full screen screenshot |
| `Shift + Print` | Area screenshot |
| `Super + Print` | Active window screenshot |

### System Controls
| Binding | Action |
|---------|--------|
| `Super + W` | Random wallpaper |
| `Volume Keys` | Audio control |
| `Brightness Keys` | Screen brightness |
| `Media Keys` | Music control |

## Configuration Structure

```
config/
├── hypr/
│   ├── hyprland.conf       # Main configuration
│   ├── environment.conf    # Environment variables
│   ├── keybindings.conf    # Key bindings
│   ├── windowrules.conf    # Window rules
│   ├── autostart.conf      # Startup applications
│   ├── monitors.conf       # Display configuration
│   ├── decoration.conf     # Visual effects
│   ├── animations.conf     # Animation settings
│   └── scripts/            # Custom scripts
├── waybar/
│   ├── config             # Waybar configuration
│   └── style.css          # Waybar styling
├── fish/
│   ├── config.fish        # Fish shell configuration
│   └── functions/         # Custom functions
├── kitty/
│   └── kitty.conf         # Terminal configuration
└── [other apps]/          # Application-specific configs
```

## Custom Scripts

### Wallpaper Management
```bash
# Set random wallpaper
~/.config/hypr/scripts/wallpaper.sh random

# Set specific wallpaper
~/.config/hypr/scripts/wallpaper.sh set /path/to/image.jpg
```

### Enhanced Screenshots
```bash
# Full screen with notification and clipboard
~/.config/hypr/scripts/screenshot.sh full

# Interactive area selection
~/.config/hypr/scripts/screenshot.sh area

# Active window capture
~/.config/hypr/scripts/screenshot.sh window
```

## Customization Guide

### Adding Wallpapers
1. Place images in `~/Pictures/wallpapers/`
2. Use `Super + W` to cycle through them randomly
3. Supported formats: JPG, PNG, WebP

### Modifying Waybar
Edit `config/waybar/config` and `config/waybar/style.css`:
- Add new modules in the config file
- Style them in the CSS file
- Restart Waybar: `killall waybar && waybar &`

### Changing Color Scheme
The setup uses Catppuccin Mocha. To change:
1. Update colors in `config/waybar/style.css`
2. Modify Fish colors in `config/fish/config.fish`
3. Adjust GTK themes in `config/gtk-*/settings.ini`

### Adding Applications to Autostart
Edit `config/hypr/autostart.conf`:
```bash
exec-once = your-application
```

## Troubleshooting

### Audio Issues
```bash
# Restart audio services
systemctl --user restart pipewire pipewire-pulse wireplumber

# Check audio devices
wpctl status
```

### Display Problems
```bash
# List monitors
hyprctl monitors

# Reload Hyprland config
hyprctl reload
```

### Theme Not Applied
```bash
# Reload GTK settings
gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
```

### Missing Icons or Cursors
```bash
# Refresh icon cache
gtk-update-icon-cache -f -t ~/.icons/Papirus-Dark
```

### Network Issues
```bash
# Start NetworkManager
sudo systemctl enable --now NetworkManager

# GUI network manager
nm-connection-editor
```

## Advanced Configuration

### Multi-Monitor Setup
Edit `config/hypr/monitors.conf`:
```bash
monitor = DP-1, 2560x1440@144, 0x0, 1
monitor = HDMI-A-1, 1920x1080@60, 2560x0, 1
```

### Custom Window Rules
Add to `config/hypr/windowrules.conf`:
```bash
windowrulev2 = float, class:(your-app)
windowrulev2 = workspace 2, class:(firefox)
```

### Performance Tuning
For gaming or performance-sensitive applications:
```bash
# Disable animations temporarily
hyprctl keyword animations:enabled false

# Enable for specific windows
windowrulev2 = immediate, class:(game-name)
```

## Backup and Restore

Your original configurations are automatically backed up during installation to:
```
~/.config/[app-name].backup.[timestamp]
```

To restore:
```bash
# Remove symlink
rm ~/.config/hypr

# Restore backup
mv ~/.config/hypr.backup.[timestamp] ~/.config/hypr
```

## Updates and Maintenance

### Updating the Configuration
```bash
cd ~/hyprdots
git pull
./install.sh  # Re-run to update symlinks
```

### Adding Your Own Modifications
1. Make changes to files in the `config/` directory
2. Test your changes
3. Commit to preserve them:
```bash
git add .
git commit -m "Custom modifications"
```

## Requirements

- **Arch Linux** (or Arch-based distribution)
- **Git** for cloning the repository
- **Base-devel** package group for building AUR packages
- **Internet connection** for downloading packages

## Contributing

Contributions are welcome! Please:
1. Fork the repository
2. Create a feature branch
3. Test your changes thoroughly
4. Submit a pull request

## License

MIT License - Use and modify freely for personal and commercial projects.