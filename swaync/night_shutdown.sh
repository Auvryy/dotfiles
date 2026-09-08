#!/usr/bin/env bash
# Night Auto-Shutdown Helper for Arch Linux / Hyprland
# Usage: ./night_shutdown.sh [HH:MM] (Defaults to 02:30)

TARGET_TIME="${1:-02:30}"

# If triggered automatically by systemd timer at 02:30 AM
if [ "$1" = "now" ] || [ "$1" = "auto" ]; then
    export WAYLAND_DISPLAY="${WAYLAND_DISPLAY:-wayland-1}"
    export DBUS_SESSION_BUS_ADDRESS="${DBUS_SESSION_BUS_ADDRESS:-unix:path=/run/user/$(id -u)/bus}"
    notify-send -u critical -a "Night Timer" "🌙 Auto-Shutdown" "02:30 AM reached. Powering off in 30 seconds..." 2>/dev/null
    sleep 30
    systemctl poweroff
    exit 0
fi

# Calculate epochs
TARGET_EPOCH=$(date -d "$TARGET_TIME" +%s 2>/dev/null)
CURRENT_EPOCH=$(date +%s)

if [ -z "$TARGET_EPOCH" ]; then
    echo "Error: Invalid time format. Please use HH:MM (e.g. 02:30)"
    exit 1
fi

# If target time is earlier today, schedule for tomorrow
if [ "$TARGET_EPOCH" -le "$CURRENT_EPOCH" ]; then
    TARGET_EPOCH=$(date -d "tomorrow $TARGET_TIME" +%s)
fi

DIFF=$((TARGET_EPOCH - CURRENT_EPOCH))
HOURS=$((DIFF / 3600))
MINS=$(((DIFF % 3600) / 60))

echo "========================================="
echo " 🌙 Night Timer Active"
echo " Target time: ${TARGET_TIME}"
echo " Time remaining: ${HOURS}h ${MINS}m (${DIFF} seconds)"
echo " Press [Ctrl + C] anytime to cancel."
echo "========================================="

notify-send -u normal -a "Night Timer" "⏰ Auto-Shutdown Scheduled" "PC will automatically power off at ${TARGET_TIME} (${HOURS}h ${MINS}m from now)."

sleep "$DIFF"

notify-send -u critical -a "Night Timer" "🌙 Shutting Down" "Target time reached (${TARGET_TIME}). Good night!"
sleep 3
systemctl poweroff
