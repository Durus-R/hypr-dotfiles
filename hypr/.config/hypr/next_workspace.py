#! /usr/bin/env python3
import subprocess
import json
import os
import time
import sys

ws = json.loads(subprocess.check_output(["hyprctl", "workspaces", "-j"]))

for w in ws:
    if w["windows"] == 0:
        os.system(f"hyprctl dispatch workspace {w['id']}")
        sys.exit()

os.system('notify-send "No free workspaces"')
sys.exit(1)
