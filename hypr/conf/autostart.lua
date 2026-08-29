-- AUTOSTART CONFIGURATION
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
