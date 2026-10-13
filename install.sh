#!/data/data/com.termux/files/usr/bin/bash

# CyberPipe-Termux Installer
# Author: Sayan Mahata (@sayan9168)
# Non-root Termux cybersecurity toolkit

set -e

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
NC='\033[0m'

PREFIX="${PREFIX:-/data/data/com.termux/files/usr}"
HOME_DIR="$HOME"
CYBERPIPE_DIR="$HOME_DIR/CyberPipe-Termux"
BIN_DIR="$PREFIX/bin"

banner() {
    clear
    echo -e "${CYAN}"
    cat << "EOF"
   ______      __              ____  _            
  / ____/_  __/ /_  ___  _____/ __ \(_)___  ___  
 / /   / / / / __ \/ _ \/ ___/ /_/ / / __ \/ _ \ 
/ /___/ /_/ / /_/ /  __/ /  / ____/ / /_/ /  __/ 
\____/\__, /_.___/\___/_/  /_/   /_/ .___/\___/  
     /____/                       /_/            
EOF
    echo -e "${NC}"
    echo -e "${YELLOW}  All-in-One Cybersecurity Pipeline for Non-Root Termux${NC}"
    echo -e "${RED}  Educational & Authorized Use Only${NC}"
    echo ""
}

check_termux() {
    if [ -z "$PREFIX" ] || [ ! -d "$PREFIX" ]; then
        echo -e "${RED}[!] This script must be run inside Termux.${NC}"
        exit 1
    fi
}

install_deps() {
    echo -e "${BLUE}[*] Updating packages...${NC}"
    pkg update -y && pkg upgrade -y

    echo -e "${BLUE}[*] Installing core dependencies...${NC}"
    pkg install -y \
        git curl wget proot proot-distro \
        python python-pip \
        nmap netcat-openbsd \
        hydra john \
        golang rust \
        clang make \
        tmux nano vim \
        jq openssl \
        termux-api \
        openssh \
        dnsutils whois \
        libxml2 libxslt \
        2>/dev/null || true

    # Python packages
    pip install --upgrade pip 2>/dev/null || true
    pip install requests beautifulsoup4 lxml colorama rich 2>/dev/null || true
}

setup_cyberpipe() {
    echo -e "${BLUE}[*] Setting up CyberPipe...${NC}"

    # Copy or link the launcher
    if [ -f "./cyberpipe" ]; then
        cp ./cyberpipe "$BIN_DIR/cyberpipe"
        chmod +x "$BIN_DIR/cyberpipe"
    fi

    # Create directories
    mkdir -p "$HOME_DIR/CyberPipe-Results"
    mkdir -p "$HOME_DIR/CyberPipe-Termux/logs"
    mkdir -p "$HOME_DIR/CyberPipe-Termux/results"

    # Make scripts executable
    find . -name "*.sh" -exec chmod +x {} \;
    chmod +x cyberpipe 2>/dev/null || true

    echo -e "${GREEN}[+] CyberPipe installed successfully!${NC}"
    echo ""
    echo -e "${CYAN}Run it with: ${YELLOW}cyberpipe${NC}"
}

install_extra_tools() {
    echo -e "${BLUE}[*] Installing popular extra tools (this may take time)...${NC}"

    # SQLMap
    if [ ! -d "$HOME_DIR/tools/sqlmap" ]; then
        mkdir -p "$HOME_DIR/tools"
        git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git "$HOME_DIR/tools/sqlmap" 2>/dev/null || true
        ln -sf "$HOME_DIR/tools/sqlmap/sqlmap.py" "$BIN_DIR/sqlmap" 2>/dev/null || true
    fi

    # Dirsearch
    if [ ! -d "$HOME_DIR/tools/dirsearch" ]; then
        git clone --depth 1 https://github.com/maurosoria/dirsearch.git "$HOME_DIR/tools/dirsearch" 2>/dev/null || true
        ln -sf "$HOME_DIR/tools/dirsearch/dirsearch.py" "$BIN_DIR/dirsearch" 2>/dev/null || true
    fi

    # theHarvester
    if [ ! -d "$HOME_DIR/tools/theHarvester" ]; then
        git clone --depth 1 https://github.com/laramies/theHarvester.git "$HOME_DIR/tools/theHarvester" 2>/dev/null || true
        cd "$HOME_DIR/tools/theHarvester" && pip install -r requirements.txt 2>/dev/null || true
        cd - > /dev/null
    fi

    # Sherlock
    if [ ! -d "$HOME_DIR/tools/sherlock" ]; then
        git clone --depth 1 https://github.com/sherlock-project/sherlock.git "$HOME_DIR/tools/sherlock" 2>/dev/null || true
        cd "$HOME_DIR/tools/sherlock" && pip install -r requirements.txt 2>/dev/null || true
        cd - > /dev/null
    fi

    # Subfinder (Go)
    if ! command -v subfinder >/dev/null 2>&1; then
        go install -v github.com/projectdiscovery/subfinder/v2/cmd/subfinder@latest 2>/dev/null || true
        [ -f "$HOME/go/bin/subfinder" ] && cp "$HOME/go/bin/subfinder" "$BIN_DIR/" 2>/dev/null || true
    fi

    # Amass
    if ! command -v amass >/dev/null 2>&1; then
        go install -v github.com/owasp-amass/amass/v4/...@master 2>/dev/null || true
        [ -f "$HOME/go/bin/amass" ] && cp "$HOME/go/bin/amass" "$BIN_DIR/" 2>/dev/null || true
    fi

    # FFUF
    if ! command -v ffuf >/dev/null 2>&1; then
        go install github.com/ffuf/ffuf/v2@latest 2>/dev/null || true
        [ -f "$HOME/go/bin/ffuf" ] && cp "$HOME/go/bin/ffuf" "$BIN_DIR/" 2>/dev/null || true
    fi

    # Holehe
    pip install holehe 2>/dev/null || true

    echo -e "${GREEN}[+] Extra tools installation finished.${NC}"
}

main() {
    banner
    check_termux

    echo -e "${YELLOW}This installer will set up CyberPipe and many non-root tools.${NC}"
    echo -e "${YELLOW}It is recommended to have good internet and 4GB+ free space.${NC}"
    echo ""
    read -p "Continue? (y/n): " confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "Aborted."
        exit 0
    fi

    install_deps
    setup_cyberpipe
    install_extra_tools

    echo ""
    echo -e "${GREEN}════════════════════════════════════════${NC}"
    echo -e "${GREEN}  Installation Complete!${NC}"
    echo -e "${GREEN}════════════════════════════════════════${NC}"
    echo ""
    echo -e "Type ${CYAN}cyberpipe${NC} to start the menu."
    echo -e "Results will be saved in ${YELLOW}~/CyberPipe-Results${NC}"
    echo ""
    echo -e "${RED}Remember: Use only on systems you own or have permission to test.${NC}"
}

main "$@"
