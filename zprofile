# Hyprland auto launch
if [ -z "$WAYLAND_DISPLAY" ] && [ "$XDG_VTNR" = 1 ]; then
    exec uwsm start hyprland-uwsm.desktop
fi