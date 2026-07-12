#!/bin/bash
set -eu

DIR="$HOME/.config/wallpaper"
SELECTED_WALLPAPER=$(find "$DIR" -type f | shuf -n 1)

awww img "${SELECTED_WALLPAPER:-}" --transition-type fade --transition-step 255
