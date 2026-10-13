#!/data/data/com.termux/files/usr/bin/bash
# Extra tools installer for CyberPipe

set -e
source "$(dirname "$0")/../lib/colors.sh" 2>/dev/null || true

TOOLS_DIR="${HOME}/tools"
mkdir -p "$TOOLS_DIR"

info "Installing additional non-root tools..."

# SQLMap
if [ ! -d "$TOOLS_DIR/sqlmap" ]; then
    git clone --depth 1 https://github.com/sqlmapproject/sqlmap.git "$TOOLS_DIR/sqlmap"
    success "SQLMap installed"
fi

# Dirsearch
if [ ! -d "$TOOLS_DIR/dirsearch" ]; then
    git clone --depth 1 https://github.com/maurosoria/dirsearch.git "$TOOLS_DIR/dirsearch"
    success "Dirsearch installed"
fi

# theHarvester
if [ ! -d "$TOOLS_DIR/theHarvester" ]; then
    git clone --depth 1 https://github.com/laramies/theHarvester.git "$TOOLS_DIR/theHarvester"
    (cd "$TOOLS_DIR/theHarvester" && pip install -r requirements.txt --quiet) || true
    success "theHarvester installed"
fi

# Sherlock
if [ ! -d "$TOOLS_DIR/sherlock" ]; then
    git clone --depth 1 https://github.com/sherlock-project/sherlock.git "$TOOLS_DIR/sherlock"
    (cd "$TOOLS_DIR/sherlock" && pip install -r requirements.txt --quiet) || true
    success "Sherlock installed"
fi

success "Extra tools installation complete."
