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

pkill -SIGUSR2 waybar 2>/dev/null
swaync-client --reload-css 2>/dev/null
swaync-client --reload-config 2>/dev/null
