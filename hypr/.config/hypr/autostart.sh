#! /bin/bash

swww-daemon &
waybar &
hypridle &
hyprctl setcursor Sweet-cursors 24
/home/kitten/scripts/gdrive.sh &
/home/kitten/scripts/ydotool.sh &
wl-paste --type text --watch cliphist store &
wl-paste --type image --watch cliphist store &
swaync &
