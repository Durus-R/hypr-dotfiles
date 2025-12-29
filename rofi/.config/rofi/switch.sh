#!/bin/bash

# Wir pipen direkt, damit die "Null-Bytes" (Trennzeichen) überleben.
# -format 'i' gibt uns den INDEX (0, 1, 2...) der Auswahl zurück.
SELECTED_INDEX=$(python3 ~/.config/rofi/windows.py | rofi -dmenu -markup-rows -format 'i' -p "Windows" -theme ~/.config/rofi/config.rasi)

# Wenn nichts ausgewählt wurde (ESC), beenden
if [ -z "$SELECTED_INDEX" ]; then
    exit 0
fi

# Jetzt holen wir uns die Adresse passend zum Index.
# Wir müssen exakt gleich sortieren wie das Python-Skript!
# jq sortiert nach workspace.id, genau wie unser Python-Script.
# sed braucht +1, weil es bei Zeile 1 anfängt, Rofi aber bei 0.
ADDRESS=$(hyprctl clients -j | jq -r 'sort_by(.workspace.id) | .[] | select(.workspace.id >= 0) | .address' | sed -n "$((SELECTED_INDEX + 1))p")

# Sprungantrieb aktivieren
hyprctl dispatch focuswindow address:$ADDRESS
