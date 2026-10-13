# 🛡️ CyberPipe-Termux

**All-in-One Cybersecurity Tool Pipeline for Non-Root Termux**

> Curated collection of the best Kali Linux + GitHub cybersecurity tools that **actually work without root** on Termux.  
> Menu-driven interface + ready-made pipelines for recon → scan → exploit workflows.

---

## ⚠️ LEGAL & ETHICAL WARNING

**This tool is for educational purposes and authorized security testing ONLY.**

- You must have **explicit written permission** before testing any system you do not own.
- Unauthorized access to computer systems is illegal under the laws of almost every country (including India IT Act 2000).
- The author and contributors take **zero responsibility** for any misuse.
- By using this tool you agree that you will only use it legally and ethically.

---

## ✨ Features

- **100% Non-Root** compatible tools
- One-command installation of 40+ carefully selected tools
- Beautiful menu system with categories
- **Pipeline Mode** – chain tools automatically (example: Domain → Subdomains → Port Scan → Directory Bruteforce → SQLi check)
- Kali NetHunter Rootless (proot) support
- Automatic dependency handling
- Logging & result export
- Easy update system

---

## 📱 Requirements

- Android device (Android 8+)
- **Termux** from F-Droid or GitHub (NOT Play Store)
- At least 4–6 GB free storage recommended
- Internet connection for installation

---

## 🚀 Quick Installation

Open Termux and run:

```bash
pkg update -y && pkg upgrade -y
pkg install git curl wget -y
git clone https://github.com/sayan9168/CyberPipe-Termux.git
cd CyberPipe-Termux
chmod +x install.sh
./install.sh
```

After installation, just type:

```bash
cyberpipe
```

---

## 🗂️ Tool Categories Included

| Category              | Tools |
|-----------------------|-------|
| Network Scanning      | Nmap, Masscan (limited), Netcat, WhatWeb, Nikto |
| Web Application       | SQLMap, Dirsearch, Gobuster, FFUF, WFuzz, WPScan |
| Recon & OSINT         | Amass, Subfinder, theHarvester, Sherlock, Recon-ng, Holehe |
| Password Attacks      | Hydra, John the Ripper, Hashid, Crunch, Cupp |
| Exploitation          | Metasploit (limited), RouterSploit, Searchsploit |
| Android Specific      | PhoneSploit, APKTool, JADX (limited) |
| Utilities             | Curl, Wget, Git, Python, Go, Ruby, Tmux |

> Many more tools can be added easily via the menu.

---

## 🔄 Pipeline Examples

1. **Full Domain Recon Pipeline**
   - Subdomain enumeration → Port scanning → Service detection → Directory bruteforce

2. **Web App Assessment Pipeline**
   - Technology detection → Directory discovery → SQL Injection testing

3. **Credential Stuffing Pipeline** (authorized targets only)
   - Wordlist generation → Brute force

You can create your own pipelines in the `pipelines/` folder.

---

## 🛠️ Manual Commands

```bash
cyberpipe                  # Launch main menu
cyberpipe --install        # Re-run tool installer
cyberpipe --update         # Update CyberPipe itself
cyberpipe --pipeline list  # Show available pipelines
```

---

## 📦 Kali NetHunter Rootless (Optional)

For a fuller Kali experience without root:

```bash
pkg install proot-distro -y
proot-distro install nethunter
proot-distro login nethunter
```

Or use the built-in option inside CyberPipe menu.

---

## 🤝 Contributing

Pull requests are welcome!  
Add new non-root compatible tools, improve pipelines, or fix bugs.

---

## 📄 License

MIT License – see [LICENSE](LICENSE)

**Remember**: With great power comes great responsibility. Use ethically.

---

Made with ❤️ for the Termux security community by **Sayan Mahata** (@sayan9168)
