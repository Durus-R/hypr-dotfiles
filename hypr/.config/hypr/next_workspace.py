#! /usr/bin/env python3
import subprocess
import json
import os
import sys

ws = json.loads(subprocess.check_output(["hyprctl", "workspaces", "-j"]))

for w in ws:
    if w["windows"] == 0:
        sys.exit(os.system(f"hyprctl dispatch workspace {w['id']}"))

os.system("bash -c notify-send \"Fehler\" \"Keine freien Arbeitsbereiche\"")
sys.exit(1)
