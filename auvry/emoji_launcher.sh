#!/usr/bin/env bash

if pidof rofi > /dev/null; then
    pkill rofi
else
    rofi -show emoji
fi