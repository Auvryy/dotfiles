-- INPUT CONFIGURATION
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Gestures/

hl.config({
    input = {
        kb_layout     = "us",
        kb_variant    = "",
        kb_model      = "",
        kb_options    = "",
        kb_rules      = "",

        follow_mouse  = 1,

        sensitivity   = -0.8,
        accel_profile = "adaptive",

        touchpad = {
            natural_scroll = true,
            scroll_factor  = 0.5,
        },
    },
})

-- Trackpad Gestures
hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})
