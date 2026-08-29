#!/usr/bin/env bash

if pidof yad > /dev/null; then
    pkill yad
fi

yad --center --title="Keybinding Hints" --no-buttons --list \
    --column="Key:" --column="" --column="Description:" \
    --timeout-indicator=bottom \
"  =   "          "        "  "SUPER KEY (Windows Key Button)" \
"" "" "" \
"  Return"         "        "  "Open Kitty terminal" \
"  E"              "        "  "Open file manager (Yazi)" \
"  B"              "        "  "Open browser (Zen Browser)" \
"  Space"          "        "  "App launcher (Rofi)" \
"  Ctrl H"         "        "  "Show keybinding hints" \
"  I"              "        "  "Toggle sunset warm mode" \
"" "" "" \
"  Q"              "        "  "Close active window" \
"  Shift Q"        "        "  "Kill active window process" \
"  G"              "        "  "Toggle floating" \
"  F"              "        "  "Toggle fullscreen" \
"  P"              "        "  "Toggle pseudo-tile (dwindle)" \
"ALT Tab"           "        "  "Cycle next window" \
"ALT Shift Tab"     "        "  "Cycle previous window" \
"" "" "" \
"  Ctrl L"         "        "  "Lock screen (Hyprlock)" \
"  Shift L"        "        "  "Power menu (Rofi)" \
"  Shift Ctrl Esc" "        "  "Exit Hyprland session" \
"" "" "" \
"  ."              "        "  "Emoji selector" \
"  V"              "        "  "Clipboard history" \
"  W"              "        "  "Select wallpaper" \
"  Shift W"        "        "  "Random wallpaper" \
"  T"              "        "  "Notification center (SwayNC)" \
"  R"              "        "  "Book launcher" \
"" "" "" \
"  S"              "        "  "Screenshot (region -> file)" \
"  Shift S"        "        "  "Screenshot (region -> clipboard)" \
"  A"              "        "  "Screenshot (screen -> file)" \
"  Shift A"        "        "  "Screenshot (screen -> clipboard)" \
"" "" "" \
"  H / J / K / L"  "        "  "Focus left / down / up / right" \
"  [← / ↓ / ↑ / →]" "       "  "Resize active window" \
"  Shift [Arrows]"  "       "  "Move active window" \
"" "" "" \
"  [1 -> 0]"       "        "  "Switch workspace 1-10" \
"  Shift [1 -> 0]" "        "  "Move window to workspace 1-10" \
"  Escape"         "        "  "Toggle special workspace (scratchpad)" \
"  Shift Escape"   "        "  "Move window to special workspace" \
"" "" "" \
"More Keybindings"  "        "  "$HOME/.config/hypr/conf/keybinding.lua"
