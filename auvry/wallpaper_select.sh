#!/usr/bin/env bash

if pidof rofi > /dev/null; then
    pkill rofi
    exit 0
fi

wallpapers_dir="$HOME/.config/wallpapers"

# 1. Rofi Thumbnail Selection (Your exact working logic)
selected_wallpaper=$(for a in "$wallpapers_dir"/*; do
    echo -en "$(basename "${a%.*}")\0icon\x1f$a\n"
done | rofi -dmenu -p " ")

# Exit safely if you hit Escape or choose nothing
[[ -z "$selected_wallpaper" ]] && exit 0

# 2. Grab the full file path
image_fullname_path=$(find "$wallpapers_dir" -type f -name "$selected_wallpaper.*" | head -n 1)

# 3. Extract the lowercase file extension
extension="${image_fullname_path##*.}"
extension=$(echo "$extension" | tr 'A-Z' 'a-z')

# Always clean up any existing video processes first
killall mpvpaper 2>/dev/null

# 4. Engine Route
if [[ "$extension" == "mp4" || "$extension" == "webm" || "$extension" == "mkv" ]]; then
    # It's a video! We fill awww with pitch black so it sits invisibly behind the video
    awww clear 000000
    
    # Run mpvpaper. If it fails or isn't installed, your system won't crash
    mpvpaper -o "--loop --no-audio --hwdec=auto" '*' "$image_fullname_path" &
else
    # It's a static image, GIF, or WebP! Use your exact working command
    awww img "$image_fullname_path" --transition-type any --transition-duration 2
fi

# 5. Run your background effects script
~/.config/auvry/wallpaper_effects.sh
