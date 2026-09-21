#!/usr/bin/env bash

if pgrep -x "waybar" > /dev/null; then
    pkill -15 -x "waybar"
    
    while pgrep -x "waybar" > /dev/null; do
        sleep 0.1
    done
fi

exec uwsm app -- waybar