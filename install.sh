#!/bin/bash

# Arch Linux Post-Install Script for Hyprland Desktop
# Author: Generated Post-Install Script
# Date: June 17, 2025

set -euo pipefail

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script directory
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Source functions
source "${SCRIPT_DIR}/scripts/functions.sh"

# Main installation function
main() {
    print_banner
    
    echo -e "${CYAN}Starting Arch Linux Hyprland post-installation setup...${NC}"
    echo
    
    # Check if running as root
    if [[ $EUID -eq 0 ]]; then
        echo -e "${RED}This script should not be run as root!${NC}"
        exit 1
    fi
    
    # Update system first
    update_system
    
    # Install core packages
    install_core_packages
    
    # Install AUR helper
    install_yay
    
    # Install fonts
    install_fonts
    
    # Setup fish shell
    setup_fish_shell
    
    # Create config directories and symlinks
    setup_config_symlinks
    
    # Configure applications
    configure_hyprland
    configure_waybar
    configure_other_apps
    
    # Setup wallpapers
    setup_wallpapers
    
    # Configure environment
    setup_environment
    
    # Final steps
    final_setup
    
    print_completion
}

# Execute main function
main "$@"
