#!/bin/bash

# ===============================
# Petroductyl Installer
# ===============================

set -e

LOG_FILE="/var/log/petroductyl-installer.log"

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
NC='\033[0m'

# Root Check
if [ "$EUID" -ne 0 ]; then
    echo -e "${RED}Please run as root.${NC}"
    exit 1
fi

# Ubuntu Version Check
if ! grep -q "20.04\|22.04" /etc/os-release; then
    echo -e "${RED}Only Ubuntu 20.04 and 22.04 are supported.${NC}"
    exit 1
fi

# Pause Function
pause_and_return() {
    echo ""
    echo -e "${GREEN}========================================${NC}"
    echo -e "${GREEN}Script executed successfully${NC}"
    echo -e "${GREEN}Press Enter to continue...${NC}"
    echo -e "${GREEN}========================================${NC}"
    read
    clear
}

# Banner
show_banner() {
    clear
    echo -e "${CYAN}"
    echo "========================================"
    echo "        PETRODUCTYL INSTALLER"
    echo "========================================"
    echo -e "${NC}"
}

# Simulated Install Functions (Replace Later)

install_panel() {
    echo -e "${YELLOW}Installing Pterodactyl Panel...${NC}"
    sleep 2
    pause_and_return
}

install_wings() {
    echo -e "${YELLOW}Installing Wings...${NC}"
    sleep 2
    pause_and_return
}

install_database() {
    echo -e "${YELLOW}Installing Database...${NC}"
    sleep 2
    pause_and_return
}

install_tailscale() {
    echo -e "${YELLOW}Installing Tailscale...${NC}"
    sleep 2
    pause_and_return
}

system_info() {
    echo -e "${CYAN}System Information:${NC}"
    echo "OS: $(lsb_release -ds)"
    echo "RAM: $(free -h | awk '/Mem:/ {print $2}')"
    echo "CPU: $(nproc) cores"
    echo "Disk: $(df -h / | awk 'NR==2 {print $2}')"
    pause_and_return
}

# Main Menu
while true; do
    show_banner
    echo "1) Install Pterodactyl Panel"
    echo "2) Install Wings"
    echo "3) Install Database"
    echo "4) Install Tailscale"
    echo "5) System Information"
    echo "0) Exit"
    echo ""
    read -p "Select an option: " option

    case $option in
        1) install_panel ;;
        2) install_wings ;;
        3) install_database ;;
        4) install_tailscale ;;
        5) system_info ;;
        0) exit 0 ;;
        *)
            echo -e "${RED}Invalid option!${NC}"
            sleep 1
            ;;
    esac
done
