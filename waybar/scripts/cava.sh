#!/usr/bin/env bash

# Kill any previous instance of waybar cava
pkill -f "cava -p /tmp/waybar_cava_config" 2>/dev/null

config_file="/tmp/waybar_cava_config"
cat << 'EOF' > "$config_file"
[general]
bars = 8
framerate = 30

[input]
method = pipewire
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# Ensure child processes terminate cleanly when the script exits
trap 'pkill -P $$ 2>/dev/null; rm -f "$config_file"' EXIT SIGINT SIGTERM

# Run cava and translate numbers to audio bars
cava -p "$config_file" | sed -u 's/;//g;s/0/ /g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;'
