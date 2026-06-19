#!/usr/bin/env bash

set -e

echo "install packages"

sudo pacman -Syu --needed --noconfirm \
	git \
	stow \
	kitty \
	foot \
	waybar \
	wofi \
	ttf-iosevka-nerd

echo "install dotfiles"

cd "$(dirname "${BASH_SOURCE[0]}")"

for pkg in */; do
    pkg_name="${pkg%/}"
    if [ "$pkg_name" != "scripts" ]; then
        echo "adopting package: $pkg_name"
        stow "$pkg_name"
    fi
done

echo "install finished"

