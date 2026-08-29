-- HYPRLAND MAIN CONFIGURATION (LUA)
-- Documentation: https://wiki.hypr.land/Configuring/Start/

-- 1. Monitors
require("conf.monitors")

-- 2. Programs / Application Definitions
require("conf.programs")

-- 3. Autostart Daemons & Services
require("conf.autostart")

-- 4. Environment Variables
require("conf.environment")

-- 5. Appearance, Decoration & Layer Rules
require("conf.appearance")

-- 6. Animations & Curves
require("conf.animation")

-- 7. Layouts (Dwindle & Master)
require("conf.layout")

-- 8. Miscellaneous Compositor Options
require("conf.misc")

-- 9. Input & Touchpad Gestures
require("conf.input")

-- 10. Keybindings & Mouse Binds (Kitty terminal prioritized)
require("conf.keybinding")

-- 11. Window Rules
require("conf.windowrule")

-- 12. Workspaces & Monitor Assignments
require("conf.workspaces")
