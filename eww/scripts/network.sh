#!/usr/bin/env bash
wifi_ssid=$(nmcli -t -f active,ssid dev wifi 2>/dev/null | grep '^yes' | cut -d: -f2 | head -n1)
if [ -n "$wifi_ssid" ]; then
    echo "󰖩 $wifi_ssid"
else
    eth=$(nmcli -t -f name,type c show --active 2>/dev/null | grep '802-3-ethernet' | cut -d: -f1 | head -n1)
    if [ -n "$eth" ]; then
        echo "󰈀 Ethernet"
    else
        echo "󰖪 Disconnected"
    fi
fi
