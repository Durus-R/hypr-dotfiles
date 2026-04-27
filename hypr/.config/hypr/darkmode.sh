#!/bin/bash

# Aktuelles Farbschema auslesen
CURRENT_STATE=$(gsettings get org.gnome.desktop.interface color-scheme)

if [ "$CURRENT_STATE" == "'prefer-dark'" ]; then
    # Auf Light Mode wechseln
    gsettings set org.gnome.desktop.interface color-scheme 'default'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita'
    notify-send -u low -t 2000 "Theme Switch" "Light Mode"
else
    # Auf Dark Mode wechseln
    gsettings set org.gnome.desktop.interface color-scheme 'prefer-dark'
    gsettings set org.gnome.desktop.interface gtk-theme 'Adwaita-dark'
    notify-send -u low -t 2000  "Theme Switch" "Dark Mode"
fi
