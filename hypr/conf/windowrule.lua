-- WINDOW RULES CONFIGURATION
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/

-- Ignore maximize requests from applications
hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

-- Fix dragging issues with XWayland popup windows
hl.window_rule({
    name       = "fix-xwayland-drags",
    match      = {
        class      = "^$",
        title      = "^$",
        xwayland   = true,
        float      = true,
        fullscreen = false,
        pin        = false,
    },
    no_focus   = true,
})

-- Disable blur for floating XWayland windows
hl.window_rule({
    match   = {
        class = "xwayland:1",
        float = true,
    },
    no_blur = true,
})

-- Stayfocused rule for sober
hl.window_rule({
    name  = "stayfocused",
    match = { class = "^sober$" },
})
