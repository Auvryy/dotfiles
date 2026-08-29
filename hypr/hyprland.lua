-- =============================================================================
-- HYPRLAND MAIN CONFIGURATION (LUA)
-- Official Hyprland 0.55+ Configuration
-- Documentation: https://wiki.hypr.land/Configuring/Start/
-- =============================================================================

--------------------------------------------------------------------------------
-- 1. MONITORS
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Monitors/
hl.monitor({
    output   = "HDMI-A-1",
    mode     = "1440x900@74.98",
    position = "0x0",
    scale    = 1,
})


--------------------------------------------------------------------------------
-- 2. PROGRAMS (KITTY TERMINAL PRIORITIZED)
--------------------------------------------------------------------------------
local terminal    = "kitty"
local fileManager = "kitty yazi"
local browser     = "zen-browser"


--------------------------------------------------------------------------------
-- 3. AUTOSTART
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Autostart/
hl.on("hyprland.start", function()
    -- Status bar & Notification daemon
    hl.exec_cmd("sleep 1 && waybar")
    hl.exec_cmd("hyprsunset -t 5000")
    hl.exec_cmd("swaync")
    hl.exec_cmd("awww-daemon & sleep 0.5 & awww init")
    hl.exec_cmd("nm-applet --indicator")

    -- Input method & utilities
    hl.exec_cmd("fcitx5")
    hl.exec_cmd("kclockd")
    hl.exec_cmd("notion-calendar")

    -- Screen sharing environment
    hl.exec_cmd("dbus-update-activation-environment --systemd WAYLAND_DISPLAY XDG_CURRENT_DESKTOP")

    -- Clipboard daemon
    hl.exec_cmd("rm -f ~/.cache/cliphist/db")
    hl.exec_cmd("wl-paste --type text --watch cliphist store")
    hl.exec_cmd("wl-paste --type image --watch cliphist store")

    -- Themes setup
    hl.exec_cmd("~/.config/auvry/gtkthemes.sh")
end)


--------------------------------------------------------------------------------
-- 4. ENVIRONMENT VARIABLES
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Environment-variables/
hl.env("XCURSOR_SIZE", "24")
hl.env("HYPRCURSOR_SIZE", "24")

hl.env("GDK_BACKEND", "wayland,x11,*")
hl.env("QT_QPA_PLATFORM", "wayland;xcb")
hl.env("QT_QPA_PLATFORMTHEME", "qt6ct")
hl.env("QT_STYLE_OVERRIDE", "kvantum")
hl.env("SDL_VIDEODRIVER", "wayland")
hl.env("MOZ_ENABLE_WAYLAND", "1")
hl.env("ELECTRON_OZONE_PLATFORM_HINT", "wayland")
hl.env("OZONE_PLATFORM", "wayland")

hl.env("GTK_IM_MODULE", "fcitx5")
hl.env("QT_IM_MODULE", "fcitx5")
hl.env("XMODIFIERS", "@im=fcitx5")
hl.env("INPUT_METHOD", "fcitx5")
hl.env("SDL_IM_MODULE", "fcitx5")


--------------------------------------------------------------------------------
-- 5. LOOK AND FEEL (GENERAL, DECORATION, ANIMATIONS, LAYOUT, MISC)
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Variables/
hl.config({
    general = {
        gaps_in          = 10,
        gaps_out         = 15,
        border_size      = 1,
        col = {
            active_border   = "rgba(cdd6f4aa)",
            inactive_border = "rgba(595959aa)",
        },
        resize_on_border = true,
        allow_tearing    = false,
        layout           = "dwindle",
    },

    decoration = {
        rounding         = 5,
        rounding_power   = 2.0,
        active_opacity   = 1.0,
        inactive_opacity = 0.95,

        shadow = {
            enabled      = true,
            range        = 4,
            render_power = 3,
            color        = "rgba(1a1a1aee)",
        },

        blur = {
            enabled           = true,
            size              = 6,
            passes            = 3,
            new_optimizations = true,
            ignore_opacity    = true,
        },
    },

    animations = {
        enabled = true,
    },

    dwindle = {
        preserve_split = true,
    },

    master = {
        new_status = "master",
    },

    misc = {
        force_default_wallpaper    = 0,
        disable_hyprland_logo       = true,
        disable_splash_rendering    = true,
        initial_workspace_tracking  = 1,
    },

    xwayland = {
        force_zero_scaling = true,
    },

    ecosystem = {
        no_update_news = true,
    },
})

-- Layer rules (Blur & Alpha for UI components)
hl.layer_rule({ match = { namespace = "waybar" }, blur = true })
hl.layer_rule({ match = { namespace = "rofi" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "logout_dialog" }, blur = true })
hl.layer_rule({ match = { namespace = "swaync-control-center" }, blur = true, ignore_alpha = 0.5 })
hl.layer_rule({ match = { namespace = "swaync-notification-window" }, blur = true, ignore_alpha = 0.5 })


--------------------------------------------------------------------------------
-- 6. ANIMATION CURVES & ANIMATION TREE
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Advanced-and-Cool/Animations/
hl.curve("ease",     { type = "bezier", points = { { 0.25, 0.1 },  { 0.25, 1.0 } } })
hl.curve("overshot", { type = "bezier", points = { { 0.13, 0.99 }, { 0.29, 1.05 } } })

hl.animation({ leaf = "windows",             enabled = true, speed = 5, bezier = "overshot", style = "gnomed" })
hl.animation({ leaf = "windowsOut",          enabled = true, speed = 5, bezier = "ease",     style = "slide bottom" })
hl.animation({ leaf = "windowsMove",         enabled = true, speed = 5, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "layers",              enabled = true, speed = 5, bezier = "ease",     style = "fade" })
hl.animation({ leaf = "fade",                enabled = true, speed = 3, bezier = "ease" })
hl.animation({ leaf = "border",              enabled = true, speed = 2, bezier = "ease" })
hl.animation({ leaf = "workspaces",          enabled = true, speed = 5, bezier = "overshot", style = "slide" })
hl.animation({ leaf = "specialWorkspace",    enabled = true, speed = 5, bezier = "default",  style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceIn",  enabled = true, speed = 5, bezier = "default",  style = "slidevert" })
hl.animation({ leaf = "specialWorkspaceOut", enabled = true, speed = 5, bezier = "default",  style = "slidevert" })


--------------------------------------------------------------------------------
-- 7. INPUT & GESTURES
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Variables/#input
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

hl.gesture({
    fingers   = 3,
    direction = "horizontal",
    action    = "workspace",
})


--------------------------------------------------------------------------------
-- 8. KEYBINDINGS
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Binds/
local mainMod = "SUPER"

-- 8.1 Primary Application Shortcuts (Kitty Prioritized)
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(terminal))
hl.bind(mainMod .. " + E",      hl.dsp.exec_cmd(fileManager))
hl.bind(mainMod .. " + B",      hl.dsp.exec_cmd('pgrep -x zen-browser && zen-browser "about:home" || (zen-browser & sleep 1.5 && zen-browser "about:home")'))
hl.bind(mainMod .. " + CTRL + H", hl.dsp.exec_cmd("~/.config/auvry/key_hints.sh"))
hl.bind(mainMod .. " + I",      hl.dsp.exec_cmd("~/.config/auvry/toggle_sunset.sh"))

-- 8.2 Window Management
hl.bind(mainMod .. " + Q",             hl.dsp.window.close())
hl.bind(mainMod .. " + SHIFT + Q",     hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"))
hl.bind(mainMod .. " + G",             hl.dsp.window.float({ action = "toggle" }))
hl.bind(mainMod .. " + P",             hl.dsp.window.pseudo({ action = "toggle" }))
hl.bind(mainMod .. " + F",             hl.dsp.window.fullscreen({ action = "toggle" }))
hl.bind("ALT + Tab",                   hl.dsp.window.cycle_next({ next = true }))
hl.bind("ALT + SHIFT + Tab",           hl.dsp.window.cycle_next({ next = false }))
hl.bind("ALT + Tab",                   hl.dsp.window.alter_zorder({ mode = "top" }))

-- 8.3 Session Controls
hl.bind(mainMod .. " + SHIFT + CTRL + Escape", hl.dsp.exit())
hl.bind(mainMod .. " + SHIFT + L",     hl.dsp.exec_cmd("~/.config/rofi/powermenu/powermenu.sh"))
hl.bind(mainMod .. " + CTRL + L",      hl.dsp.exec_cmd("hyprlock"))

-- 8.4 Launchers & Utilities
hl.bind(mainMod .. " + Space",     hl.dsp.exec_cmd("~/.config/auvry/app_launcher.sh"))
hl.bind(mainMod .. " + R",         hl.dsp.exec_cmd("~/.config/auvry/book_launcher.sh"))
hl.bind(mainMod .. " + period",    hl.dsp.exec_cmd("~/.config/auvry/emoji_launcher.sh"))
hl.bind(mainMod .. " + V",         hl.dsp.exec_cmd("~/.config/auvry/clipboard_launcher.sh"))
hl.bind(mainMod .. " + W",         hl.dsp.exec_cmd("~/.config/auvry/wallpaper_select.sh"))
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/auvry/wallpaper_random.sh"))
hl.bind(mainMod .. " + T",         hl.dsp.exec_cmd("swaync-client -t -sw"))
hl.bind(mainMod .. " + ALT + S",   hl.dsp.exec_cmd("~/.local/bin/sort-downloads.sh"))

-- 8.5 Screenshots (Hyprshot)
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"))
hl.bind(mainMod .. " + A",         hl.dsp.exec_cmd("hyprshot -m output -o $HOME/Pictures/Screenshots"))
hl.bind(mainMod .. " + S",         hl.dsp.exec_cmd("hyprshot -m region --freeze -o $HOME/Pictures/Screenshots"))
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --freeze --clipboard-only"))

-- 8.6 Window Focus Navigation (Vim Keys: hjkl)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- 8.7 Window Resizing (Arrow keys)
hl.bind(mainMod .. " + Left",  hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + Right", hl.dsp.window.resize({ x =  50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + Up",    hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + Down",  hl.dsp.window.resize({ x = 0, y =  50, relative = true }), { repeating = true })

-- 8.8 Window Moving (Shift + Arrow keys)
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + Up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + Down",  hl.dsp.window.move({ direction = "d" }))

-- 8.9 Special Workspace (Scratchpad)
hl.bind(mainMod .. " + Escape",         hl.dsp.workspace.toggle_special())
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.window.move({ workspace = "special" }))

-- 8.10 Workspace Switching & Moving (1 - 10)
for i = 1, 10 do
    local key = (i == 10) and "0" or tostring(i)
    local ws  = tostring(i)
    hl.bind(mainMod .. " + " .. key,         hl.dsp.focus({ workspace = ws }))
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
end

-- 8.11 Workspace Mouse Scrolling
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

-- 8.12 Mouse Dragging / Resizing
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(),   { mouse = true })
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

-- 8.13 Hardware Audio & Media Keys
hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })

hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { repeating = true, locked = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { repeating = true, locked = true })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("brightnessctl s 10%+"),                             { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("brightnessctl s 10%-"),                             { repeating = true, locked = true })

hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })


--------------------------------------------------------------------------------
-- 9. WINDOW RULES & WORKSPACES
--------------------------------------------------------------------------------
-- See https://wiki.hypr.land/Configuring/Basics/Window-Rules/
-- See https://wiki.hypr.land/Configuring/Basics/Workspace-Rules/

hl.window_rule({
    name           = "suppress-maximize-events",
    match          = { class = ".*" },
    suppress_event = "maximize",
})

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

hl.window_rule({
    match   = {
        class = "xwayland:1",
        float = true,
    },
    no_blur = true,
})

hl.window_rule({
    name  = "stayfocused",
    match = { class = "^sober$" },
})

-- Workspace rules (HDMI-A-1)
hl.workspace_rule({
    workspace = "1",
    monitor   = "HDMI-A-1",
    default   = true,
})

for i = 2, 10 do
    hl.workspace_rule({
        workspace = tostring(i),
        monitor   = "HDMI-A-1",
    })
end
