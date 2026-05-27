#!/usr/bin/env bash

if pidof rofi > /dev/null; then
    pkill rofi
else
    cliphist list | rofi -dmenu -p "Clipboard" | cliphist decode | wl-copy
fi