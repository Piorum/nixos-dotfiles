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
