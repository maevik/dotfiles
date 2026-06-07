#!/bin/bash

if [[ $EUID -ne 0 ]]; then
    echo "script must run as root (sudo ./clean.sh) to clean system related packages and caches"
    exit 1
fi

echo "[~] starting system cleanup"

if [ -f /var/lib/pacman/db.lck ]; then
    echo "[-] pacman is currently locked (update in progress). skipping pacman cleanup."
else
    echo "[+] cleaning pacman cache..."
    pacman -Scc --noconfirm 
    if [ -n "$(pacman -Qdtq)" ]; then
        pacman -Rns $(pacman -Qdtq) --noconfirm
    else
        echo "no orphaned packages found."
    fi
fi

echo "[+] vacuuming system logs (keeping last 3 days)..."
journalctl --vacuum-time=3d

echo "[+] cleaning user cache folders..."
rm -rf /home/$SUDO_USER/.cache/thumbnails/* 2>/dev/null
rm -rf /home/$SUDO_USER/.cache/mozilla/firefox/* 2>/dev/null
rm -rf /tmp/* 2>/dev/null

echo "[+] emptying trash..."
rm -rf /home/$SUDO_USER/.local/share/Trash/* 2>/dev/null

echo "[+] cleaning bash history..."
cat /dev/null > "/home/$SUDO_USER/.bash_history"
history -c

echo "[~] finished system cleanup..."
