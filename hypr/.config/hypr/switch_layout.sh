#! /usr/bin/bash
if [ "$(hyprctl getoption general:layout -j | jq -r ".str")" = "dwindle" ]; 
    then hyprctl keyword general:layout master 
         
    else hyprctl keyword general:layout dwindle  
        fi
