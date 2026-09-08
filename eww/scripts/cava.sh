#!/usr/bin/env bash
# =============================================================================
# Eww Live CAVA Audio Spectrum Visualizer
# Uses PipeWire direct capture for real-time, low-latency audio visualization
# =============================================================================

CONFIG_FILE="/tmp/eww_cava_config"

cat << "EOF" > "$CONFIG_FILE"
[general]
bars = 16
framerate = 40
autosens = 1
sensitivity = 135
lower_cutoff_freq = 50
higher_cutoff_freq = 10000

[input]
method = pipewire
source = auto

[output]
method = raw
raw_target = /dev/stdout
data_format = ascii
ascii_max_range = 7
EOF

# Clean up any lingering cava instance for this config
pkill -f "cava -p $CONFIG_FILE" 2>/dev/null

trap 'pkill -P $$ 2>/dev/null; exit 0' EXIT INT TERM

# Run cava and translate numeric levels (0-7) to unicode blocks ( -█)
cava -p "$CONFIG_FILE" 2>/dev/null | sed -u "s/;//g;s/0/▁/g;s/1/▂/g;s/2/▃/g;s/3/▄/g;s/4/▅/g;s/5/▆/g;s/6/▇/g;s/7/█/g;"
