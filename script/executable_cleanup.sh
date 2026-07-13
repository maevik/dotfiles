#!/bin/bash

if [ "$EUID" -ne 0 ]; then
  echo "-- requires root"
  exit 1
fi

USER_NAME=${SUDO_USER:-$USER}
USER_HOME=$(eval echo ~$USER_NAME)

echo "-- cleaning pacman and paru cache..."
rm -f /var/cache/pacman/pkg/download-* 2>/dev/null
pacman -Sc --noconfirm 2>/dev/null

sudo -u "$USER_NAME" yay -Sc --noconfirm --noprovide --nodeps 2>/dev/null

echo "-- removing orphan packages..."
if pacman -Qtdq > /dev/null; then
  pacman -Rns $(pacman -Qtdq) --noconfirm
fi
sudo -u "$USER_NAME" paru -Rns $(sudo -u "$USER_NAME" paru -Qtdq) --noconfirm 2>/dev/null

echo "-- cleaning systemd journal..."
journalctl --vacuum-time=2weeks

echo "-- cleaning home cache..."
rm -rf "$USER_HOME"/.cache/*
rm -rf /root/.cache/*

echo "-- system cleanup complete"

