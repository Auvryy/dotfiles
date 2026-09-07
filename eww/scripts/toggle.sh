#!/usr/bin/env bash
# Eww Left Dashboard Toggle Script with Click-Away Closer

ACTION="$1"
is_open=$(eww active-windows 2>/dev/null | grep "left_dashboard")

if [ "$ACTION" = "close" ] || [ -n "$is_open" ]; then
    eww close left_dashboard left_dashboard_closer 2>/dev/null
else
    eww open left_dashboard_closer 2>/dev/null
    eww open left_dashboard 2>/dev/null
fi
