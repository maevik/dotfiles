#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
  echo "-- This script must be run as root."
  exit 1
fi

USER_NAME=${SUDO_USER:-$USER}
USER_HOME=$(eval echo ~"$USER_NAME")

if command -v paru &>/dev/null; then
  AUR_HELPER="paru"
elif command -v yay &>/dev/null; then
  AUR_HELPER="yay"
else
  AUR_HELPER=""
fi

echo "==> Cleaning package caches (pacman + AUR)"
pacman -Scc --noconfirm
if [ -n "$AUR_HELPER" ]; then
  sudo -u "$USER_NAME" "$AUR_HELPER" -Scc --noconfirm
fi
if command -v paccache &>/dev/null; then
  paccache -rk0 2>/dev/null || true
fi

echo "==> Removing orphan packages (including config files)"
if pacman -Qtdq | grep -q .; then
  pacman -Rns --noconfirm $(pacman -Qtdq)
fi
if [ -n "$AUR_HELPER" ]; then
  orphans=$(sudo -u "$USER_NAME" "$AUR_HELPER" -Qtdq 2>/dev/null || true)
  if [ -n "$orphans" ]; then
    sudo -u "$USER_NAME" "$AUR_HELPER" -Rns --noconfirm $orphans
  fi
fi

echo "==> Aggressively cleaning systemd journal"
journalctl --vacuum-size=100M 2>/dev/null || true
journalctl --vacuum-time=1days 2>/dev/null || true

echo "==> Cleaning temporary files"
systemd-tmpfiles --clean --remove 2>/dev/null || true
find /tmp -mindepth 1 -delete 2>/dev/null || true
find /var/tmp -mindepth 1 -delete 2>/dev/null || true

echo "==> Removing unused locales"
if command -v localepurge &>/dev/null; then
  localepurge
else
  # Fallback: delete locale files except English
  find /usr/share/locale -mindepth 1 -maxdepth 1 -type d ! -name 'en*' -exec rm -rf {} + 2>/dev/null || true
fi

echo "==> Cleaning package manager metadata"
rm -f /var/lib/pacman/sync/*.old 2>/dev/null || true

echo "==> Cleaning home caches and trash"
rm -rf "$USER_HOME"/.cache/* 2>/dev/null || true
rm -rf /root/.cache/* 2>/dev/null || true
rm -rf "$USER_HOME"/.local/share/Trash/* 2>/dev/null || true
rm -rf "$USER_HOME"/.thumbnails/* 2>/dev/null || true
rm -f "$USER_HOME"/.local/share/recently-used.xbel 2>/dev/null || true

echo "==> Removing broken symlinks in home and root"
find "$USER_HOME" -xtype l -delete 2>/dev/null || true
find /root -xtype l -delete 2>/dev/null || true

echo "==> Cleanup completed successfully"

