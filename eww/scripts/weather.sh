#!/usr/bin/env bash
# Santa Cruz, Laguna Weather Script
CACHE_FILE="/tmp/eww_laguna_weather.json"

# Update cache every 10 minutes
if [ ! -f "$CACHE_FILE" ] || [ $(find "$CACHE_FILE" -mmin +10 2>/dev/null) ]; then
    curl -s --max-time 3 "https://api.open-meteo.com/v1/forecast?latitude=14.2817&longitude=121.4172&current_weather=true" > "$CACHE_FILE" 2>/dev/null
fi

case "$1" in
    temp)
        temp=$(jq -r '.current_weather.temperature // empty' "$CACHE_FILE" 2>/dev/null)
        if [ -n "$temp" ]; then
            printf "%.0f°C\n" "$temp"
        else
            echo "27°C"
        fi
        ;;
    desc)
        code=$(jq -r '.current_weather.weathercode // empty' "$CACHE_FILE" 2>/dev/null)
        if [ -z "$code" ]; then
            echo "Partly Cloudy"
        elif [ "$code" -eq 0 ]; then
            echo "Clear Sky"
        elif [ "$code" -le 3 ]; then
            echo "Partly Cloudy"
        elif [ "$code" -le 48 ]; then
            echo "Foggy"
        elif [ "$code" -le 67 ]; then
            echo "Rain Showers"
        elif [ "$code" -le 77 ]; then
            echo "Snowy"
        elif [ "$code" -le 99 ]; then
            echo "Thunderstorm"
        else
            echo "Cloudy"
        fi
        ;;
    icon)
        code=$(jq -r '.current_weather.weathercode // empty' "$CACHE_FILE" 2>/dev/null)
        if [ -z "$code" ]; then
            echo "⛅"
        elif [ "$code" -eq 0 ]; then
            echo "☀️"
        elif [ "$code" -le 3 ]; then
            echo "⛅"
        elif [ "$code" -le 48 ]; then
            echo "🌫️"
        elif [ "$code" -le 67 ]; then
            echo "🌧️"
        elif [ "$code" -le 99 ]; then
            echo "⛈️"
        else
            echo "🌤️"
        fi
        ;;
    location)
        echo "Santa Cruz, Laguna"
        ;;
esac
