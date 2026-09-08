#!/usr/bin/env bash
# Eww Left Dashboard Toggle Script with Click-Away Closer

ACTION="$1"

# Ensure Eww daemon is alive
if ! eww ping &>/dev/null; then
    eww daemon &
    sleep 0.3
fi

# Check if either dashboard or closer window is currently active
is_open=$(eww active-windows 2>/dev/null | grep -E "left_dashboard")

case "$ACTION" in
    open)
        eww open left_dashboard_closer 2>/dev/null
        eww open left_dashboard 2>/dev/null
        ;;
    close)
        eww close left_dashboard left_dashboard_closer 2>/dev/null
        ;;
    *)
        # Default toggle behavior: if open, close; if closed, open.
        if [ -n "$is_open" ]; then
            eww close left_dashboard left_dashboard_closer 2>/dev/null
        else
            eww open left_dashboard_closer 2>/dev/null
            eww open left_dashboard 2>/dev/null
        fi
        ;;
esac
