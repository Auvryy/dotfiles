#!/usr/bin/env bash

# Toggle: kill if already running
if pgrep -x "rofi" > /dev/null; then
    pkill -x rofi
    exit 0
fi

dir="$HOME/.config/rofi/powermenu"
theme='style'

# CMDs
lastlogin="`last $USER | head -n1 | tr -s ' ' | cut -d' ' -f5,6,7`"
uptime="`uptime -p | sed -e 's/up //g'`"
host=`hostname`
date="`date '+%A, %B %d'`"
time="`date '+%H:%M'`"
kernel="`uname -r`"

# Options
shutdown='󰐥'
reboot='󰑓'
lock='󰌾'
logout='󰍃'

# Rofi CMD
rofi_cmd() {
    rofi -dmenu \
        -p "  $USER@$host" \
        -mesg "  $time  |  󰸗 $date  |  󰥔 $uptime  |  󰒋 $kernel" \
        -theme ${dir}/${theme}.rasi
}

run_rofi() {
    echo -e "$lock\n$logout\n$reboot\n$shutdown" | rofi_cmd
}

chosen="$(run_rofi)"
case ${chosen} in
    $shutdown)
        shutdown now
        ;;
    $reboot)
        reboot
        ;;
    $lock)
        hyprlock
        ;;
    $logout)
        hyprctl dispatch exit
        ;;
esac
