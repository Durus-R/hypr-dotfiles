#!/bin/bash

# KONFIGURATION
WALLPAPER_DIR="$HOME/Bilder/wallpapers"
DEFAULT_IMG="$WALLPAPER_DIR/default.jpg"

# Startwert für das Gedächtnis
last_workspace=1

# Funktion zum Wechseln mit Richtung
change_wallpaper() {
    local img="$1"
    local direction="$2"
    
    # Richtung übersetzen in Winkel für swww
    # 30 = Wisch nach Rechts (wir gehen zu höherer Nummer)
    # 210 = Wisch nach Links (wir gehen zu niedrigerer Nummer)
    if [ "$direction" == "right" ]; then
        angle=0
    else
        angle=180
    fi

    swww img "$img" \
        --transition-type wipe \
        --transition-angle "$angle" \
        --transition-duration 1 \
        --transition-fps 144
}

handle() {
    case $1 in
        workspace*)
            # 1. Neue Workspace ID extrahieren (z.B. "1", "2")
            workspace_id=${1#*>>}
            
            # Sicherheitscheck: Ist es eine Zahl? (Manche Workspaces haben Namen)
            if ! [[ "$workspace_id" =~ ^[0-9]+$ ]]; then
                return
            fi

            # 2. Richtung berechnen (Vergleich mit Gedächtnis)
            if [ "$workspace_id" -gt "$last_workspace" ]; then
                direction="right"
            elif [ "$workspace_id" -lt "$last_workspace" ]; then
                direction="left"
            else
                # Gleicher Workspace (beim Start oder Reload)? Egal.
                direction="right"
            fi

            # 3. Das richtige Bild suchen
            TARGET_FILE="$WALLPAPER_DIR/workspace_${workspace_id}.png"

            echo ${workspace_id} > ~/.last_wallpaper.txt
            
            if [ -f "$TARGET_FILE" ]; then
                img_to_use="$TARGET_FILE"
            else
                #img_to_use="$DEFAULT_IMG"
                echo foo > /dev/null
            fi
            
            # 4. Befehl ausführen
            change_wallpaper "$img_to_use" "$direction"
            
            # 5. Gedächtnis aktualisieren
            last_workspace=$workspace_id
            ;;
    esac
}

# Socket abhören
socat -U - UNIX-CONNECT:$XDG_RUNTIME_DIR/hypr/$HYPRLAND_INSTANCE_SIGNATURE/.socket2.sock | while read -r line; do handle "$line"; done
