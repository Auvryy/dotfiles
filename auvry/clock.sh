#!/usr/bin/env bash
color=$(grep "@define-color main-blue" ~/.config/colors/colors.css | grep -oP '#[0-9a-fA-F]{6}')
color="${color:-#B0CBFF}"

# Pick size based on terminal width (each size unit needs ~17 cols)
cols=$(tput cols)
if   [ "$cols" -ge 120 ]; then size=3
elif [ "$cols" -ge 80  ]; then size=2
else                           size=1
fi

mode="${1:-clock}"
shift 2>/dev/null

case "$mode" in
    clock)      tclock --color "$color" --size "$size" clock "$@" ;;
    stopwatch)  tclock --color "$color" --size "$size" stopwatch ;;
    timer)      tclock --color "$color" --size "$size" timer --no-millis --duration "$@" ;;
    countdown)  tclock --color "$color" --size "$size" countdown "$@" ;;
    *)          echo "Usage: clock [clock|stopwatch|timer|countdown]" ;;
esac
