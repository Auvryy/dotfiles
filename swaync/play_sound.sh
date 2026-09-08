#!/usr/bin/env bash
# SwayNC Notification Sound Player
SOUND_FILE="$HOME/.config/swaync/sounds/tuturu.mp3"

# Ignore silent apps
if [[ "$SWAYNC_APP_NAME" =~ (?i)(gpu-screen-recorder|screen-recorder) ]] || [[ "$SWAYNC_SUMMARY" =~ (?i)(recording|screen recorder|replay) ]]; then
    exit 0
fi

if [ -f "$SOUND_FILE" ]; then
    if command -v pw-play >/dev/null 2>&1; then
        pw-play "$SOUND_FILE" >/dev/null 2>&1 &
    elif command -v paplay >/dev/null 2>&1; then
        paplay "$SOUND_FILE" >/dev/null 2>&1 &
    elif command -v mpv >/dev/null 2>&1; then
        mpv --no-video --really-quiet "$SOUND_FILE" >/dev/null 2>&1 &
    fi
fi
