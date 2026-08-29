-- ANIMATIONS CONFIGURATION
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/

hl.config({
    animations = {
        enabled = true,
    },
})

-- Bezier Curves
hl.curve("ease",     { type = "bezier", points = { { 0.25, 0.1 },  { 0.25, 1.0 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.13, 0.99 }, { 0.29, 1.05 } } })

-- Animations
hl.animation({ leaf = "windows",             enabled = true, speed = 5, bezier = "overshot", style = "gnomed" })
hl.animation({ leaf = "windowsOut",          enabled = true, speed = 5, bezier = "ease",     style = "slide bottom" })
hl.animation({ leaf = "windowsMove",         enabled = true, speed = 5, bezier = "overshot", style = "slide" })

hl.animation({ leaf = "layers",              enabled = true, speed = 5, bezier = "ease",     style = "fade" })
hl.animation({ leaf = "fade",                enabled = true, speed = 3, bezier = "ease" })
hl.animation({ leaf = "border",              enabled = true, speed = 2, bezier = "ease" })
hl.animation({ leaf = "workspaces",          enabled = true, speed = 5, bezier = "overshot", style = "slide" })

-- Special Workspace animations
hl.animation({ leaf = "specialWorkspace",    enabled = true, speed = 5, bezier = "default",  style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 5, bezier = "default",  style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 5, bezier = "default",  style = "slidevert" })
