#!/usr/bin/env bash
wallpaper="$1"
[ -z "$wallpaper" ] && exit 0
[ -f "$wallpaper" ] || exit 0

ext="${wallpaper##*.}"
ext="${ext,,}"
case "$ext" in
    mp4|webm|mkv) exit 0 ;;
esac

matugen image "$wallpaper" -m dark --prefer saturation || exit 0

pkill waybar 2>/dev/null
sleep 0.5
waybar &
swaync-client --reload-css 2>/dev/null
swaync-client --reload-config 2>/dev/null
kill -SIGUSR1 $(pgrep -a kitty | awk '{print $1}') 2>/dev/null

# Patch oh-my-posh palette from generated colors.css
css=~/.config/colors/colors.css
get() { grep "@define-color $1" "$css" | grep -oP '#[0-9a-fA-F]{6}'; }

jq --arg bg       "$(get background)" \
   --arg fg       "$(get foreground)" \
   --arg select   "$(get select)" \
   --arg blue     "$(get blue)" \
   --arg cyan     "$(get cyan)" \
   --arg purple   "$(get purple)" \
   --arg red      "$(get red)" \
   --arg green    "$(get green)" \
   --arg yellow   "$(get yellow)" \
   --arg orange   "$(get orange)" \
   --arg pink     "$(get pink)" \
   --arg gray     "$(get gray)" \
   --arg mainblue "$(get main-blue)" \
   '.palette.bg       = $bg     |
    .palette.fg       = $fg     |
    .palette.black    = $bg     |
    .palette.white    = $fg     |
    .palette.blue     = $blue   |
    .palette["main-blue"] = $mainblue |
    .palette.lavender = $purple |
    .palette.cyan     = $cyan   |
    .palette.teal     = $cyan   |
    .palette.green    = $green  |
    .palette.purple   = $purple |
    .palette.red      = $red    |
    .palette.pink     = $pink   |
    .palette.yellow   = $yellow |
    .palette.orange   = $orange |
    .palette.select   = $gray' \
   ~/.config/ohmyposh/viet.omp.json > /tmp/omp.json \
   && mv /tmp/omp.json ~/.config/ohmyposh/viet.omp.json
