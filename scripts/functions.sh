#!/bin/bash

# Helper functions for Arch Linux Hyprland installation

print_banner() {
    echo -e "${PURPLE}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                Arch Linux Hyprland Setup                    ║"
    echo "║              Post-Installation Script v1.0                  ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

print_completion() {
    echo -e "${GREEN}"
    echo "╔══════════════════════════════════════════════════════════════╗"
    echo "║                    Installation Complete!                   ║"
    echo "║                                                              ║"
    echo "║  Please reboot your system to start using Hyprland.         ║"
    echo "║  Login and select Hyprland from your display manager.       ║"
    echo "║                                                              ║"
    echo "║  Key bindings:                                               ║"
    echo "║  Super + D        -> Open application launcher (fuzzel)     ║"
    echo "║  Super + Return   -> Open terminal (kitty)                  ║"
    echo "║  Super + Q        -> Close window                            ║"
    echo "║  Super + M        -> Exit Hyprland                          ║"
    echo "║  Super + F        -> Toggle fullscreen                      ║"
    echo "║  Super + V        -> Toggle floating                        ║"
    echo "╚══════════════════════════════════════════════════════════════╝"
    echo -e "${NC}"
}

handle_error() {
    local error_msg="$1"
    echo -e "${RED}Error: $error_msg${NC}"
    echo -e "${YELLOW}Do you want to continue anyway? (y/N): ${NC}"
    read -r response
    if [[ ! "$response" =~ ^[Yy]$ ]]; then
        echo -e "${RED}Installation aborted.${NC}"
        exit 1
    fi
}

update_system() {
    echo -e "${BLUE}Updating system packages...${NC}"
    if ! sudo pacman -Syu --noconfirm; then
        handle_error "Failed to update system packages"
    fi
    echo -e "${GREEN}System updated successfully.${NC}"
    echo
}

install_core_packages() {
    echo -e "${BLUE}Installing core packages...${NC}"
    
    local packages=(
        "hyprland"
        "kitty"
        "thunar"
        "firefox"
        "nano"
        "waybar"
        "fuzzel"
        "dunst"
        "hyprpaper"
        "fish"
        "btop"
        "fastfetch"
        "polkit-gnome"
        "xdg-desktop-portal-hyprland"
        "qt5-wayland"
        "qt6-wayland"
        "qt5ct"
        "qt6ct"
        "pipewire"
        "pipewire-pulse"
        "pipewire-alsa"
        "wireplumber"
        "brightnessctl"
        "playerctl"
        "grim"
        "slurp"
        "wl-clipboard"
        "pavucontrol"
        "network-manager-applet"
        "bluez"
        "bluez-utils"
        "blueman"
        "papirus-icon-theme"
        "bibata-cursor-theme"
        "gsimplecal"
        "galculator"
    )
    
    for package in "${packages[@]}"; do
        echo -e "${CYAN}Installing $package...${NC}"
        if ! sudo pacman -S --noconfirm "$package"; then
            handle_error "Failed to install $package"
        fi
    done
    
    echo -e "${GREEN}Core packages installed successfully.${NC}"
    echo
}

install_yay() {
    echo -e "${BLUE}Installing yay AUR helper...${NC}"
    
    if command -v yay &> /dev/null; then
        echo -e "${YELLOW}yay is already installed.${NC}"
        return 0
    fi
    
    cd /tmp
    if ! git clone https://aur.archlinux.org/yay-bin.git; then
        handle_error "Failed to clone yay-bin repository"
    fi
    
    cd yay-bin
    if ! makepkg -si --noconfirm; then
        handle_error "Failed to build and install yay"
    fi
    
    cd "$SCRIPT_DIR"
    echo -e "${GREEN}yay installed successfully.${NC}"
    echo
}

install_fonts() {
    echo -e "${BLUE}Installing fonts...${NC}"
    
    local fonts=(
        "ttf-fira-code"
        "ttf-font-awesome"
        "noto-fonts"
        "noto-fonts-emoji"
        "ttf-jetbrains-mono"
        "ttf-liberation"
    )
    
    for font in "${fonts[@]}"; do
        echo -e "${CYAN}Installing $font...${NC}"
        if ! sudo pacman -S --noconfirm "$font"; then
            handle_error "Failed to install $font"
        fi
    done
    
    echo -e "${GREEN}Fonts installed successfully.${NC}"
    echo
}

setup_fish_shell() {
    echo -e "${BLUE}Setting up fish shell...${NC}"
    
    # Change default shell to fish
    if ! chsh -s /usr/bin/fish; then
        handle_error "Failed to change default shell to fish"
    fi
    
    echo -e "${GREEN}Fish shell configured successfully.${NC}"
    echo
}

setup_config_symlinks() {
    echo -e "${BLUE}Setting up configuration symlinks...${NC}"
    
    local config_dirs=("hypr" "waybar" "fuzzel" "kitty" "dunst" "fish" "nano" "gtk-3.0" "gtk-4.0" "qt5ct" "qt6ct" "Thunar" "fontconfig" "mimeapps.list")
    
    # Create ~/.config if it doesn't exist
    mkdir -p "$HOME/.config"
    
    for item in "${config_dirs[@]}"; do
        local source_path="${SCRIPT_DIR}/config/${item}"
        local target_path="$HOME/.config/${item}"
        
        echo -e "${CYAN}Setting up $item configuration...${NC}"
        
        # Handle files vs directories differently
        if [[ -f "$source_path" ]]; then
            # It's a file
            if [[ -e "$target_path" ]]; then
                local backup_path="${target_path}.backup.$(date +%Y%m%d_%H%M%S)"
                echo -e "${YELLOW}Backing up existing $item to $backup_path${NC}"
                mv "$target_path" "$backup_path"
            fi
            
            # Create symlink for file
            if ! ln -sf "$source_path" "$target_path"; then
                handle_error "Failed to create symlink for $item"
            fi
        else
            # It's a directory
            if [[ -e "$target_path" ]]; then
                local backup_path="${target_path}.backup.$(date +%Y%m%d_%H%M%S)"
                echo -e "${YELLOW}Backing up existing $item to $backup_path${NC}"
                mv "$target_path" "$backup_path"
            fi
            
            # Create symlink for directory
            if ! ln -sf "$source_path" "$target_path"; then
                handle_error "Failed to create symlink for $item"
            fi
        fi
    done
    
    echo -e "${GREEN}Configuration symlinks created successfully.${NC}"
    echo
}

configure_hyprland() {
    echo -e "${BLUE}Configuring Hyprland...${NC}"
    # Configuration is handled via symlinks
    echo -e "${GREEN}Hyprland configured successfully.${NC}"
    echo
}

configure_waybar() {
    echo -e "${BLUE}Configuring Waybar...${NC}"
    # Configuration is handled via symlinks
    echo -e "${GREEN}Waybar configured successfully.${NC}"
    echo
}

configure_other_apps() {
    echo -e "${BLUE}Configuring other applications...${NC}"
    # All configurations are handled via symlinks
    echo -e "${GREEN}Applications configured successfully.${NC}"
    echo
}

setup_wallpapers() {
    echo -e "${BLUE}Setting up wallpapers directory...${NC}"
    
    local wallpaper_dir="${SCRIPT_DIR}/assets/wallpapers"
    mkdir -p "$wallpaper_dir"
    
    echo -e "${YELLOW}Please add your wallpapers to: $wallpaper_dir${NC}"
    echo -e "${YELLOW}The first wallpaper found will be used as default.${NC}"
    
    echo -e "${GREEN}Wallpaper directory created successfully.${NC}"
    echo
}

setup_environment() {
    echo -e "${BLUE}Setting up environment variables...${NC}"
    
    # Create environment file for Hyprland (this will be replaced by symlink)
    echo -e "${YELLOW}Environment variables will be managed via symlinked configuration.${NC}"
    
    echo -e "${GREEN}Environment configured successfully.${NC}"
    echo
}

final_setup() {
    echo -e "${BLUE}Performing final setup steps...${NC}"
    
    # Enable services
    sudo systemctl enable bluetooth
    
    # Create desktop entry for Hyprland if using display manager
    if [[ ! -f /usr/share/wayland-sessions/hyprland.desktop ]]; then
        sudo tee /usr/share/wayland-sessions/hyprland.desktop > /dev/null << EOF
[Desktop Entry]
Name=Hyprland
Comment=Hyprland compositor
Exec=Hyprland
Type=Application
EOF
    fi
    
    echo -e "${GREEN}Final setup completed successfully.${NC}"
    echo
}
