#!/usr/bin/env bash

wait_for_exit() {
    while pgrep -x "waybar" > /dev/null; do
        :
    done
}

killall waybar

wait_for_exit

waybar