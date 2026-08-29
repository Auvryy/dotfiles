-- KEYBINDINGS CONFIGURATION
-- See https://wiki.hypr.land/Configuring/Basics/Binds/
-- See https://wiki.hypr.land/Configuring/Basics/Dispatchers/

local programs = require("modules.programs")

local mainMod = "SUPER"

--------------------------------------------------------------------------------
-- 1. PRIMARY APPLICATION SHORTCUTS (KITTY TERMINAL PRIORITIZED)
--------------------------------------------------------------------------------

-- Launch Primary Terminal (Kitty)
hl.bind(mainMod .. " + Return", hl.dsp.exec_cmd(programs.terminal), {
    description = "Launch Primary Terminal (Kitty)",
})

-- Launch File Manager (Kitty + Yazi)
hl.bind(mainMod .. " + E", hl.dsp.exec_cmd(programs.fileManager), {
    description = "Launch Terminal File Manager (Yazi)",
})

-- Launch Browser (Zen Browser)
hl.bind(mainMod .. " + B", hl.dsp.exec_cmd('pgrep -x zen-browser && zen-browser "about:home" || (zen-browser & sleep 1.5 && zen-browser "about:home")'), {
    description = "Launch Web Browser (Zen Browser)",
})

-- Keybinding hints & Night light toggle
hl.bind(mainMod .. " + CTRL + H", hl.dsp.exec_cmd("~/.config/auvry/key_hints.sh"), {
    description = "Show Keybinding Hints",
})
hl.bind(mainMod .. " + I", hl.dsp.exec_cmd("~/.config/auvry/toggle_sunset.sh"), {
    description = "Toggle Hyprsunset Warm Mode",
})

--------------------------------------------------------------------------------
-- 2. WINDOW MANAGEMENT
--------------------------------------------------------------------------------

-- Close active window
hl.bind(mainMod .. " + Q", hl.dsp.window.close(), {
    description = "Close Active Window",
})

-- Force kill active window process
hl.bind(mainMod .. " + SHIFT + Q", hl.dsp.exec_cmd("hyprctl activewindow | grep pid | tr -d 'pid:' | xargs kill"), {
    description = "Force Kill Active Window Process",
})

-- Window states
hl.bind(mainMod .. " + G", hl.dsp.window.float({ action = "toggle" }), {
    description = "Toggle Floating State",
})
hl.bind(mainMod .. " + P", hl.dsp.window.pseudo({ action = "toggle" }), {
    description = "Toggle Pseudo Tiling (Dwindle)",
})
hl.bind(mainMod .. " + F", hl.dsp.window.fullscreen({ action = "toggle" }), {
    description = "Toggle Fullscreen",
})

-- Alt-Tabbing
hl.bind("ALT + Tab", hl.dsp.window.cycle_next({ next = true }))
hl.bind("ALT + SHIFT + Tab", hl.dsp.window.cycle_next({ next = false }))
hl.bind("ALT + Tab", hl.dsp.window.alter_zorder({ mode = "top" }))

-- Session controls
hl.bind(mainMod .. " + SHIFT + CTRL + Escape", hl.dsp.exit(), {
    description = "Exit Hyprland Session",
})
hl.bind(mainMod .. " + SHIFT + L", hl.dsp.exec_cmd("~/.config/rofi/powermenu/powermenu.sh"), {
    description = "Open Power Menu (Rofi)",
})
hl.bind(mainMod .. " + CTRL + L", hl.dsp.exec_cmd("hyprlock"), {
    description = "Lock Screen (Hyprlock)",
})

--------------------------------------------------------------------------------
-- 3. UTILITIES & LAUNCHERS
--------------------------------------------------------------------------------

-- Application launcher
hl.bind(mainMod .. " + Space", hl.dsp.exec_cmd("~/.config/auvry/app_launcher.sh"), {
    description = "Application Launcher",
})

-- Book launcher
hl.bind(mainMod .. " + R", hl.dsp.exec_cmd("~/.config/auvry/book_launcher.sh"), {
    description = "Book Launcher",
})

-- Emoji selector
hl.bind(mainMod .. " + period", hl.dsp.exec_cmd("~/.config/auvry/emoji_launcher.sh"), {
    description = "Select Emoji",
})

-- Clipboard manager
hl.bind(mainMod .. " + V", hl.dsp.exec_cmd("~/.config/auvry/clipboard_launcher.sh"), {
    description = "Open Clipboard History",
})

-- Wallpaper selectors
hl.bind(mainMod .. " + W", hl.dsp.exec_cmd("~/.config/auvry/wallpaper_select.sh"), {
    description = "Select Wallpaper",
})
hl.bind(mainMod .. " + SHIFT + W", hl.dsp.exec_cmd("~/.config/auvry/wallpaper_random.sh"), {
    description = "Set Random Wallpaper",
})

-- SwayNC notification center toggle
hl.bind(mainMod .. " + T", hl.dsp.exec_cmd("swaync-client -t -sw"), {
    description = "Toggle Notification Center",
})

-- Sort downloads script
hl.bind(mainMod .. " + ALT + S", hl.dsp.exec_cmd("~/.local/bin/sort-downloads.sh"), {
    description = "Sort Downloads Folder",
})

--------------------------------------------------------------------------------
-- 4. SCREENSHOTS (HYPRSHOT)
--------------------------------------------------------------------------------

-- Fullscreen -> clipboard
hl.bind(mainMod .. " + SHIFT + A", hl.dsp.exec_cmd("hyprshot -m output --clipboard-only"), {
    description = "Screenshot Fullscreen to Clipboard",
})

-- Fullscreen -> save file
hl.bind(mainMod .. " + A", hl.dsp.exec_cmd("hyprshot -m output -o $HOME/Pictures/Screenshots"), {
    description = "Screenshot Fullscreen to File",
})

-- Region -> save file
hl.bind(mainMod .. " + S", hl.dsp.exec_cmd("hyprshot -m region --freeze -o $HOME/Pictures/Screenshots"), {
    description = "Screenshot Region to File",
})

-- Region -> clipboard
hl.bind(mainMod .. " + SHIFT + S", hl.dsp.exec_cmd("hyprshot -m region --freeze --clipboard-only"), {
    description = "Screenshot Region to Clipboard",
})

--------------------------------------------------------------------------------
-- 5. FOCUS & WINDOW NAVIGATION
--------------------------------------------------------------------------------

-- Move focus (Vim keys: hjkl)
hl.bind(mainMod .. " + H", hl.dsp.focus({ direction = "l" }))
hl.bind(mainMod .. " + L", hl.dsp.focus({ direction = "r" }))
hl.bind(mainMod .. " + K", hl.dsp.focus({ direction = "u" }))
hl.bind(mainMod .. " + J", hl.dsp.focus({ direction = "d" }))

-- Resize active window (Arrow keys)
hl.bind(mainMod .. " + Left",  hl.dsp.window.resize({ x = -50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + Right", hl.dsp.window.resize({ x =  50, y = 0, relative = true }), { repeating = true })
hl.bind(mainMod .. " + Up",    hl.dsp.window.resize({ x = 0, y = -50, relative = true }), { repeating = true })
hl.bind(mainMod .. " + Down",  hl.dsp.window.resize({ x = 0, y =  50, relative = true }), { repeating = true })

-- Move active window (Shift + Arrow keys)
hl.bind(mainMod .. " + SHIFT + Left",  hl.dsp.window.move({ direction = "l" }))
hl.bind(mainMod .. " + SHIFT + Right", hl.dsp.window.move({ direction = "r" }))
hl.bind(mainMod .. " + SHIFT + Up",    hl.dsp.window.move({ direction = "u" }))
hl.bind(mainMod .. " + SHIFT + Down",  hl.dsp.window.move({ direction = "d" }))

--------------------------------------------------------------------------------
-- 6. WORKSPACES
--------------------------------------------------------------------------------

-- Special / Scratchpad Workspace
hl.bind(mainMod .. " + Escape", hl.dsp.workspace.toggle_special(), {
    description = "Toggle Special Workspace (Scratchpad)",
})
hl.bind(mainMod .. " + SHIFT + Escape", hl.dsp.window.move({ workspace = "special" }), {
    description = "Move Active Window to Special Workspace",
})

-- Switch to workspace (1-10) and Move active window to workspace (1-10)
for i = 1, 10 do
    local key = (i == 10) and "0" or tostring(i)
    local ws  = tostring(i)

    -- Focus workspace [1-10]
    hl.bind(mainMod .. " + " .. key, hl.dsp.focus({ workspace = ws }))

    -- Move active window to workspace [1-10]
    hl.bind(mainMod .. " + SHIFT + " .. key, hl.dsp.window.move({ workspace = ws }))
end

-- Scroll through existing workspaces with mainMod + scroll
hl.bind(mainMod .. " + mouse_down", hl.dsp.focus({ workspace = "e+1" }))
hl.bind(mainMod .. " + mouse_up",   hl.dsp.focus({ workspace = "e-1" }))

--------------------------------------------------------------------------------
-- 7. MOUSE DRAG & RESIZE
--------------------------------------------------------------------------------

-- Move window with mainMod + LMB drag
hl.bind(mainMod .. " + mouse:272", hl.dsp.window.drag(), { mouse = true })

-- Resize window with mainMod + RMB drag
hl.bind(mainMod .. " + mouse:273", hl.dsp.window.resize(), { mouse = true })

--------------------------------------------------------------------------------
-- 8. AUDIO & MEDIA HARDWARE KEYS
--------------------------------------------------------------------------------

-- Volume step adjustments
hl.bind(mainMod .. " + equal", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true })
hl.bind(mainMod .. " + minus", hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"), { repeating = true })

-- Laptop multimedia keys
hl.bind("XF86AudioRaiseVolume",   hl.dsp.exec_cmd("wpctl set-volume -l 1 @DEFAULT_AUDIO_SINK@ 5%+"), { repeating = true, locked = true })
hl.bind("XF86AudioLowerVolume",   hl.dsp.exec_cmd("wpctl set-volume @DEFAULT_AUDIO_SINK@ 5%-"),       { repeating = true, locked = true })
hl.bind("XF86AudioMute",          hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle"),      { repeating = true, locked = true })
hl.bind("XF86AudioMicMute",       hl.dsp.exec_cmd("wpctl set-mute @DEFAULT_AUDIO_SOURCE@ toggle"),    { repeating = true, locked = true })
hl.bind("XF86MonBrightnessUp",    hl.dsp.exec_cmd("brightnessctl s 10%+"),                             { repeating = true, locked = true })
hl.bind("XF86MonBrightnessDown",  hl.dsp.exec_cmd("brightnessctl s 10%-"),                             { repeating = true, locked = true })

-- Playerctl media controls
hl.bind("XF86AudioNext",  hl.dsp.exec_cmd("playerctl next"),       { locked = true })
hl.bind("XF86AudioPause", hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPlay",  hl.dsp.exec_cmd("playerctl play-pause"), { locked = true })
hl.bind("XF86AudioPrev",  hl.dsp.exec_cmd("playerctl previous"),   { locked = true })
