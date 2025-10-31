#!/usr/bin/env bash

wait_for_exit() {
    while pgrep -x "waybar" > /dev/null; do
        :
    done
}

kill -15 $(pgrep waybar)

wait_for_exit

waybar