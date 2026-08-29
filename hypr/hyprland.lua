-- =============================================================================
-- Hyprland Main Configuration (Lua Entrypoint)
-- =============================================================================

-- Add ~/.config/hypr/ to package.path for clean requires
package.path = package.path .. ";" .. os.getenv("HOME") .. "/.config/hypr/?.lua;" .. os.getenv("HOME") .. "/.config/hypr/?/init.lua"

-- Load modular configurations
require("modules.monitors")
require("modules.programs")
require("modules.autostart")
require("modules.environment")
require("modules.appearance")
require("modules.animation")
require("modules.input")
require("modules.layout")
require("modules.misc")
require("modules.keybinding")
require("modules.windowrule")
require("modules.workspaces")
