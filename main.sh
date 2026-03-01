#!/usr/bin/env bash

# ==========================================================
# PIXDRAQ CLOUD SYSTEM | SAFE BOOTSTRAP EDITION
# DATE: 2026-02-12 | UI-TYPE: ASC-II HYPER-VISUAL
# ==========================================================

set -euo pipefail

LOG_FILE="/var/log/pixdraq-installer.log"
HOST="run.pixdraqhost.in"
URL="https://${HOST}"

# --- Colors ---
R='\033[1;31m'
G='\033[1;32m'
Y='\033[1;33m'
C='\033[1;36m'
W='\033[1;37m'
DG='\033[1;90m'
NC='\033[0m'

draw_banner() {
    clear
    echo -e "${G}"
    cat << "EOF"
 ██████╗ ██╗██╗  ██╗██████╗ ██████╗  █████╗  ██████╗ 
 ██╔══██╗██║╚██╗██╔╝██╔══██╗██╔══██╗██╔══██╗██╔════╝ 
 ██████╔╝██║ ╚███╔╝ ██║  ██║██████╔╝███████║██║  ███╗
 ██╔═══╝ ██║ ██╔██╗ ██║  ██║██╔══██╗██╔══██║██║   ██║
 ██║     ██║██╔╝ ██╗██████╔╝██║  ██║██║  ██║╚██████╔╝
 ╚═╝     ╚═╝╚═╝  ╚═╝╚═════╝ ╚═╝  ╚═╝╚═╝  ╚═╝ ╚═════╝ 
EOF
    echo -e "${NC}"
    echo -e " ${R}──[ ${W}SAFE MODE${R} ]${NC}${DG}────────────────────────────${NC}"
    echo ""
}

pause_and_exit() {
    echo ""
    echo -e "${G}========================================${NC}"
    echo -e "${G}Script executed successfully${NC}"
    echo -e "${G}Press Enter to exit...${NC}"
    echo -e "${G}========================================${NC}"
    read
    exit 0
}

# --- START ---
draw_banner

echo -e "${Y}Target Host:${NC} ${C}${HOST}${NC}"
echo ""

read -p "Do you want to connect and download remote payload? (y/n): " confirm

if [[ "$confirm" != "y" ]]; then
    echo -e "${R}Operation cancelled.${NC}"
    exit 1
fi

echo -e "${C}Downloading payload...${NC}"

payload="$(mktemp)"
trap "rm -f $payload" EXIT

if curl -fsSL -A "Pixdraq-Agent" -o "$payload" "$URL"; then
    echo -e "${G}Download successful.${NC}"
else
    echo -e "${R}Failed to download payload.${NC}"
    exit 1
fi

echo ""
echo -e "${Y}Preview of downloaded payload (first 20 lines):${NC}"
echo "--------------------------------------------------"
head -n 20 "$payload"
echo "--------------------------------------------------"
echo ""

read -p "Execute this payload? (y/n): " execute_confirm

if [[ "$execute_confirm" == "y" ]]; then
    echo -e "${C}Executing payload...${NC}"
    bash "$payload" | tee -a "$LOG_FILE"
    pause_and_exit
else
    echo -e "${R}Execution cancelled.${NC}"
    exit 1
fi
