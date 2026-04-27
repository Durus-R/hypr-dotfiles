#!/bin/bash

# Finde den fokussierten Monitor (dort wo die Maus ist)
MONITOR=$(hyprctl monitors -j | jq -r '.[] | select(.focused == true) | .name')

# Prüfe kurz, ob der Monitorname wirklich gefunden wurde, 
# und führe dann hyprshot gezielt für diesen Monitor aus
if [ -n "$MONITOR" ]; then
    hyprshot -m output -m "$MONITOR"
else
    # Fallback, falls etwas schiefgeht
    hyprshot -m output
fi
