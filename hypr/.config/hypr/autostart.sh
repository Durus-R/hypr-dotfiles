#! /bin/bash

rclone mount gdrive: ~/GoogleDrive --daemon &
swww-daemon &
waybar &
hypridle &
hyprctl setcursor Sweet-cursors 24
/home/kitten/scripts/ydotool.sh &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
swaync &
discord --start-minimized &
kdeconnect-indicator &
~/.config/hypr/init_wallpaper.sh
