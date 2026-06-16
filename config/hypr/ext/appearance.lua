-- appearance

hl.config({
    general = {
        gaps_in = 0,
        gaps_out = 0,

        border_size = 0,

        col = {
            active_border = "rgb(00FFFF)",
            inactive_border = "rgb(1C1C1C)",
        },

        resize_on_border = false,

        allow_tearing = true,
    },

    decoration = {
        rounding = 0,

        active_opacity = 1,
        inactive_opacity = 1,
        
        shadow = {
            enabled = false,
        },

        blur = {
            enabled = false,
        },
    },


    animations = {
        enabled = false,
    },

    misc = {
        force_default_wallpaper = 2,
        disable_hyprland_logo = false,
        enable_anr_dialog = false,
    },
})

hl.curve("basic", { type = "bezier", points = { {0.75,0}, {0.25,1} }})

hl.animation({ leaf = "windows", enabled = true, speed = 0.2, bezier = "basic" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 0.2, bezier = "basic" })
hl.animation({ leaf = "border", enabled = true, speed = 1, bezier = "basic" })
hl.animation({ leaf = "fade", enabled = true, speed = 7, bezier = "basic" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 0.2, bezier = "basic" })
