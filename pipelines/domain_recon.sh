#!/data/data/com.termux/files/usr/bin/bash
# Domain Full Recon Pipeline
# Usage: ./domain_recon.sh example.com

DOMAIN="$1"
if [ -z "$DOMAIN" ]; then
    echo "Usage: $0 <domain>"
    exit 1
fi

OUT="${HOME}/CyberPipe-Results/pipeline_${DOMAIN}_$(date +%F_%H%M)"
mkdir -p "$OUT"

echo "[*] Domain Recon Pipeline started for $DOMAIN"
echo "[*] Output directory: $OUT"

# 1. Subdomains
echo "[1] Subdomain enumeration..."
if command -v subfinder >/dev/null 2>&1; then
    subfinder -d "$DOMAIN" -silent -o "$OUT/subdomains.txt"
else
    echo "$DOMAIN" > "$OUT/subdomains.txt"
fi

# 2. Basic Nmap on main domain
echo "[2] Nmap on main domain..."
nmap -sT -Pn -T4 --top-ports 200 "$DOMAIN" -oN "$OUT/nmap_main.txt" 2>/dev/null || true

# 3. WhatWeb
echo "[3] Technology detection..."
if command -v whatweb >/dev/null 2>&1; then
    whatweb "http://$DOMAIN" "https://$DOMAIN" > "$OUT/whatweb.txt" 2>/dev/null || true
fi

# 4. Directory discovery
echo "[4] Directory discovery..."
if [ -f "${HOME}/tools/dirsearch/dirsearch.py" ]; then
    python "${HOME}/tools/dirsearch/dirsearch.py" -u "http://$DOMAIN" -e php,html,js,txt,json -q -o "$OUT/dirs.txt" 2>/dev/null || true
fi

echo "[+] Pipeline completed. Results saved in $OUT"
ls -la "$OUT"
