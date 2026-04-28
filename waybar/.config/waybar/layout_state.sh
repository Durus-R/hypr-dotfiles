#!/bin/bash

# Aktuelles Layout und Workspace abfragen
LAYOUT=$(hyprctl getoption general:layout -j | jq -r ".str")
WORKSPACE=$(hyprctl activeworkspace -j | jq -r ".id")
WIN_COUNT=$(hyprctl activeworkspace -j | jq -r ".windows")

if [ "$LAYOUT" = "master" ]; then
    if [ "$WIN_COUNT" -gt 0 ]; then
        # Zähle alle nicht-schwebenden Fenster auf dem aktiven Workspace.
        # Finde die kleinste X-Koordinate (den Master-Bereich links) und 
        # zähle alle Fenster, die an dieser Koordinate liegen.
        MASTER_COUNT=$(hyprctl clients -j | jq -r --argjson ws "$WORKSPACE" '
            [ .[] | select(.workspace.id == $ws and .floating == false) ]
            | if length == 0 then 0 else
                (map(.at[0]) | min) as $min_x
                | map(select(.at[0] <= $min_x + 5)) | length
              end
        ')
    else
        MASTER_COUNT=0
    fi
    # Ausgabe für Waybar anpassen (z. B. "Master: 2")
    #TEXT="Master"
    TEXT="/home/kitten/Bilder/master_layout.png"
    CLASS="master"
else
    #TEXT="Dwindle"
    TEXT="/home/kitten/Bilder/dwindle_layout.png"
    CLASS="dwindle"
fi

# JSON-Ausgabe an Waybar
#echo "{\"text\": \"$TEXT [$WIN_COUNT]\", \"class\": \"$CLASS\", \"tooltip\": \"Aktuelles Layout: $LAYOUT\nMaster-Fenster: $MASTER_COUNT\nGesamt: $WIN_COUNT\"}"
echo "$TEXT"
echo "Windows: $WIN_COUNT"
