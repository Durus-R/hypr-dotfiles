#! /bin/bash

rclone mount gdrive: ~/Drive --daemon &
awww-daemon &
waybar &
hypridle &
hyprctl setcursor Sweet-cursors 24
#/home/kitten/scripts/ydotool.sh &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
swaync &
discord --start-minimized &
#kdeconnect-indicator &
rquickshare &
~/.config/hypr/init_wallpaper.sh
gsettings set org.gnome.shell.extensions.user-theme name 'WhiteSur-Dark-pink'
gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
gsettings set org.gnome.desktop.interface gtk-theme 'WhiteSur-Dark-solid-pink'
gsettings set org.gnome.desktop.interface cursor-theme 'Sweet-Cursors'
