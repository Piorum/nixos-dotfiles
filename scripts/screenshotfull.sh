#!/usr/bin/env bash
set -euo pipefail

# Create temp file early so trap can clean it
tmpfile=$(mktemp /tmp/screenshot.XXXXXX.png)
cleanup() {
    if [[ -n "${tmpfile:-}" && "$tmpfile" == /tmp/screenshot.*.png && -f "$tmpfile" ]]; then
        rm -f -- "$tmpfile"
    fi
    # Always restore cursor
    hyprctl keyword cursor:invisible false >/dev/null 2>&1 || true
}
trap cleanup EXIT

# Hide cursor briefly
hyprctl keyword cursor:invisible true
sleep 0.05

# Cursor position
read -r cx cy <<< "$(hyprctl cursorpos | tr -d ',')"

# Get monitor list as JSON
monitors=$(hyprctl monitors -j)

# Find monitor containing cursor
region=$(echo "$monitors" | jq -r --argjson cx "$cx" --argjson cy "$cy" '
    .[] | select($cx >= .x and $cx < (.x + .width) and $cy >= .y and $cy < (.y + .height))
    | "\(.x),\(.y) \(.width)x\(.height)"')

# If nothing found, default to first monitor
if [[ -z "$region" ]]; then
    region=$(echo "$monitors" | jq -r '.[0] | "\(.x),\(.y) \(.width)x\(.height)"')
fi

# Take screenshot
grim -g "$region" "$tmpfile"

# Restore cursor immediately after grim
hyprctl keyword cursor:invisible false

# Launch swappy
swappy -f "$tmpfile"
