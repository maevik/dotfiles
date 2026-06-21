-- https://wiki.hypr.land/Configuring/Basics/Variables/

hl.config({
    general = {
        gaps_in          = 0, -- 2.5 default
        gaps_out         = 0, -- 2.5 default
        border_size      = 0,
        col              = {
            active_border = { colors = { "rgba(595959aa)", "rgba(595959aa)" }, angle = 45 },
            -- active_border   = { colors = {"rgba(89b4faee)", "rgba(212121ee)"}, angle = 45 },
            inactive_border = "rgba(21212100)",
        },
        resize_on_border = false,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 0, -- default 20
        rounding_power   = 0, -- default 2
        active_opacity   = 1.0,
        inactive_opacity = 1.0,

        blur             = {
            enabled  = true,
            size     = 5,
            passes   = 3,
            vibrancy = 1.1696,
        },
    },

    animations = {
        enabled = false,
    },

    input = {
        repeat_rate = 50,
        repeat_delay = 300,
    }
})

-- bezier curves
hl.curve("easeOutQuint", { type = "bezier", points = { { 0.23, 1 }, { 0.32, 1 } } })
hl.curve("easeInOutCubic", { type = "bezier", points = { { 0.65, 0.05 }, { 0.36, 1 } } })
hl.curve("linear", { type = "bezier", points = { { 0, 0 }, { 1, 1 } } })
hl.curve("almostLinear", { type = "bezier", points = { { 0.5, 0.5 }, { 0.75, 1 } } })
hl.curve("quick", { type = "bezier", points = { { 0.15, 0 }, { 0.1, 1 } } })

-- custom overshoot
hl.curve("overshoot", { type = "bezier", points = { { 0, 0 }, { 0.1, 1.1 } } })

-- spring curves
hl.curve("easy", { type = "spring", mass = 1, stiffness = 71.2633, dampening = 15.8273644 })

-- animation trees
hl.animation({ leaf = "global", enabled = true, speed = 10, bezier = "default" })
hl.animation({ leaf = "border", enabled = true, speed = 5.39, bezier = "easeOutQuint" })
hl.animation({ leaf = "windows", enabled = true, speed = 4.79, spring = "easy" })
hl.animation({ leaf = "windowsIn", enabled = true, speed = 4.1, spring = "easy", style = "popin 87%" })
hl.animation({ leaf = "windowsOut", enabled = true, speed = 1.49, bezier = "linear", style = "popin 87%" })
hl.animation({ leaf = "fadeIn", enabled = true, speed = 1.73, bezier = "almostLinear" })
hl.animation({ leaf = "fadeOut", enabled = true, speed = 1.46, bezier = "almostLinear" })
hl.animation({ leaf = "fade", enabled = true, speed = 3.03, bezier = "quick" })
hl.animation({ leaf = "layers", enabled = true, speed = 3.81, bezier = "easeOutQuint" })
hl.animation({ leaf = "layersIn", enabled = true, speed = 4, bezier = "easeOutQuint", style = "fade" })
hl.animation({ leaf = "layersOut", enabled = true, speed = 1.5, bezier = "linear", style = "fade" })
hl.animation({ leaf = "fadeLayersIn", enabled = true, speed = 1.79, bezier = "almostLinear" })
hl.animation({ leaf = "fadeLayersOut", enabled = true, speed = 1.39, bezier = "almostLinear" })
hl.animation({ leaf = "workspaces", enabled = true, speed = 1.94, bezier = "easeInOutCubic", style = "slide" })
hl.animation({ leaf = "workspacesIn", enabled = true, speed = 1.21, bezier = "overshoot", style = "slide" })
hl.animation({ leaf = "workspacesOut", enabled = true, speed = 1.94, bezier = "overshoot", style = "slide" })
hl.animation({ leaf = "zoomFactor", enabled = true, speed = 7, bezier = "quick" })

-- Layout Specific Configurations
hl.config({
    dwindle = {
        preserve_split = true,
    },
    master = {
        new_status = "master",
    },
    scrolling = {
        fullscreen_on_one_column = true,
    },
    misc = {
        force_default_wallpaper = -1,
        disable_hyprland_logo   = false,
    },
})
