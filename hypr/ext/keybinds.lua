-- keybinds

local terminal = "kitty"
local fileManager = "kitty -e /home/username/Documents/Sunfire/Sunfire/bin/Release/net10.0/linux-x64/publish/Sunfire.sh -U"
local menu = "tofi-drun | xargs hyprctl dispatch exec --"
local screenshot = "~/.scripts/screenshot.sh"
local screenshotFull = "~/.scripts/screenshotfull.sh"
local restartWaybar = "~/.scripts/restart_waybar.sh"
local hideWaybar = "kill -10 $(pgrep waybar)"

hl.bind(mainMod .. " + Q", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd(menu))
hl.bind(mainMod .. " + Print", hl.dsp.exec_cmd(screenshot))
hl.bind(mainMod .. " + SHIFT + Print", hl.dsp.exec_cmd(screenshotFull))
hl.bind(mainMod .. " + SHIFT + CTRL + ALT + P", hl.dsp.exec_cmd(restartWaybar))
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd(hideWaybar))

hl.bind(mainMod .. " + C", hl.dsp.window.close())
hl.bind(mainMod .. " + M", hl.dsp.exec_cmd("command -v hyprshutdown >/dev/null 2>&1 && hyprshutdown || hyprctl dispatch 'hl.dsp.exit()'"))
hl.bind(mainMod .. " + V", hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ mode = "fullscreen", action = "toggle" }))

hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })
hl.bind(mainMod .. " + SHIFT + mouse:272", hl.dsp.window.resize(), { mouse = true })
