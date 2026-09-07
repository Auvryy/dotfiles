#!/usr/bin/env bash
case "$1" in
    get)
        wpctl get-volume @DEFAULT_AUDIO_SINK@ | awk '{print int($2 * 100)}'
        ;;
    get-icon)
        status=$(wpctl get-volume @DEFAULT_AUDIO_SINK@)
        if echo "$status" | grep -q "MUTED"; then
            echo "󰝟"
        else
            vol=$(echo "$status" | awk '{print int($2 * 100)}')
            if [ "$vol" -ge 65 ]; then
                echo "󰕾"
            elif [ "$vol" -ge 30 ]; then
                echo "󰖀"
            else
                echo "󰕿"
            fi
        fi
        ;;
    set)
        wpctl set-volume @DEFAULT_AUDIO_SINK@ "$2%"
        ;;
    toggle)
        wpctl set-mute @DEFAULT_AUDIO_SINK@ toggle
        ;;
esac
