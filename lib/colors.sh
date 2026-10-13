#!/data/data/com.termux/files/usr/bin/bash
# Color definitions for CyberPipe

RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
PURPLE='\033[0;35m'
WHITE='\033[1;37m'
NC='\033[0m' # No Color

success() { echo -e "${GREEN}[+]${NC} $1"; }
error()   { echo -e "${RED}[-]${NC} $1"; }
info()    { echo -e "${BLUE}[*]${NC} $1"; }
warn()    { echo -e "${YELLOW}[!]${NC} $1"; }
