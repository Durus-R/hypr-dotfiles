#! /usr/bin/bash

workspace_id=$(shuf -i 1-8 -n 1)
WALLPAPER_DIR="$HOME/Bilder/wallpapers"
DEFAULT_IMG="$WALLPAPER_DIR/workspace_${workspace_id}.png"
hyprctl dispatch workspace $workspace_id 
swww img "${DEFAULT_IMG}" --transition-type none 
