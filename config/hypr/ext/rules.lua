-- rules

hl.window_rule({
    name  = "suppress-maximize-events",
    match = { class = ".*" },

    suppress_event = "maximize",
})
hl.window_rule({
    name  = "fix-xwayland-drags",
    match = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },

    no_focus = true,
})
hl.window_rule({
    name = "steam-immediate-game",
    match = {
        class = "^steam_app_[0-9]+$",
    },
    content = "game",
    immediate = true,
})
hl.window_rule({
    name = "osu!-immediate-game",
    match = {
        class = "^(osu!)$",
    },
    content = "game",
    immediate = true,
})