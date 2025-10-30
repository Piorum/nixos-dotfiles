#!/usr/bin/env bash

image_name=$1

if [ -z "$2" ]; then
    image_path="~/.cache/$image_name"
elif [ "$2" -eq 1 ]; then
    image_path="~/Pictures/$image_name"
else
    image_path="$2/$image_name"
fi

hyprctl hyprpaper unload all

hyprctl hyprpaper preload $image_path

hyprctl hyprpaper wallpaper "DP-4,$image_path"
hyprctl hyprpaper wallpaper "DP-5,$image_path"
hyprctl hyprpaper wallpaper "DP-6,$image_path"
