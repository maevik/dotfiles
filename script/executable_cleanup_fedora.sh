#!/bin/bash

set -e

if [ "$EUID" -ne 0 ]; then
  echo "-- This script must be run as root."
  exit 1
fi

USER_NAME=${SUDO_USER:-$USER}
USER_HOME=$(eval echo ~"$USER_NAME")

echo "==> Cleaning DNF package cache and metadata"
dnf clean all

echo "==> Removing orphan/unused packages"
dnf autoremove -y

echo "==> Cleaning Flatpak unused runtimes and apps"
if command -v flatpak &>/dev/null; then
  flatpak uninstall --unused -y 2>/dev/null || true
  sudo -u "$USER_NAME" flatpak uninstall --unused -y 2>/dev/null || true
fi

echo "==> Vacuuming systemd logs"
journalctl --vacuum-size=100M 2>/dev/null || true
journalctl --vacuum-time=1d 2>/dev/null || true

echo "==> Cleaning temporary files"
systemd-tmpfiles --clean --remove 2>/dev/null || true
find /tmp -mindepth 1 -delete 2>/dev/null || true
find /var/tmp -mindepth 1 -delete 2>/dev/null || true

echo "==> Cleaning crash reports and core dumps"
if command -v coredumpctl &>/dev/null; then
  coredumpctl vacuum --keep-until=1d 2>/dev/null || true
fi
rm -rf /var/spool/abrt/* 2>/dev/null || true

echo "==> Cleaning user and root caches and trash"
rm -rf "$USER_HOME"/.cache/* 2>/dev/null || true
rm -rf /root/.cache/* 2>/dev/null || true
rm -rf "$USER_HOME"/.local/share/Trash/* 2>/dev/null || true
rm -rf "$USER_HOME"/.thumbnails/* 2>/dev/null || true
rm -f "$USER_HOME"/.local/share/recently-used.xbel 2>/dev/null || true

echo "==> Removing broken symlinks in home and root"
find "$USER_HOME" -xtype l -delete 2>/dev/null || true
find /root -xtype l -delete 2>/dev/null || true

echo "==> Cleanup completed successfully"
