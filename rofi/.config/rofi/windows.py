#!/usr/bin/env python3
import json
import subprocess
import sys
import html # Wichtig für Sicherheit bei Fenstertiteln

# Nerd Fonts Map
ICON_MAP = {
    "kitty": "",
    "firefox": "",
    "vesktop": "", # Discord Clients heißen oft anders
    #"discord": "",
    "spotify": "",
    "code": "",
    "thunar": "",
    "obsidian": "",
    "steam": "",
    "dolphin": ""
}
DEFAULT_ICON = ""
COLOR_ACCENT = "#00ff99" 
COLOR_DIM = "#6c7086"
COLOR_TITLE = "#cdd6f4"

def get_windows():
    try:
        output = subprocess.check_output(["hyprctl", "clients", "-j"])
        clients = json.loads(output)
    except Exception:
        return []

    # Sortierung muss 100% identisch mit dem Bash-Script sein!
    clients.sort(key=lambda x: x['workspace']['id'])
    
    formatted_list = []
    
    for client in clients:
        ws_id = client['workspace']['id']
        if ws_id < 0: continue 

        # HTML-Escaping, falls ein Fenstertitel "<" oder ">" enthält
        title = html.escape(client['title'])
        # Wir kürzen den Titel, falls er extrem lang ist (sieht cleaner aus)
        if len(title) > 60:
            title = title[:60] + "..."
            
        cls = client['class'].lower()
        
        # Icon Suche (Safe)
        icon = DEFAULT_ICON
        for key, val in ICON_MAP.items():
            if key in cls:
                icon = val
                break
        
        # Hier ist das Layout. Ich habe ein paar Spaces mehr eingefügt.
        # <span fallback> verhindert Fehler bei fehlenden Fonts
        display_str = (
            f"<span weight='bold' foreground='{COLOR_ACCENT}'>[{ws_id}]</span>   "
            f"<span foreground='{COLOR_DIM}' size='large'>{icon}</span>   "
            f"<span foreground='{COLOR_TITLE}'>{title}</span>"
        )
        
        # WICHTIG: Das \0 (Null-Byte) startet die Metadaten.
        # icon\x1f... sagt Rofi, welches Icon (vom Icon-Theme) es links anzeigen soll.
        # Wir nutzen einfach die Klasse als Icon-Name (z.B. "firefox").
        formatted_list.append(f"{display_str}\0icon\x1f{client['class']}")

    return formatted_list

if __name__ == "__main__":
    for line in get_windows():
        print(line)
