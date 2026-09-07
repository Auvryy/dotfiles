#!/usr/bin/env bash
# Music Player Script prioritizing Spotify
PLAYER="spotify,%any"
COVER_DEST="/tmp/eww_music_cover.png"

case "$1" in
    title)
        title=$(playerctl --player="$PLAYER" metadata --format "{{title}}" 2>/dev/null)
        if [ -n "$title" ]; then
            if [ ${#title} -gt 24 ]; then
                echo "${title:0:22}..."
            else
                echo "$title"
            fi
        else
            echo "No Music Playing"
        fi
        ;;
    artist)
        artist=$(playerctl --player="$PLAYER" metadata --format "{{artist}}" 2>/dev/null)
        if [ -n "$artist" ]; then
            if [ ${#artist} -gt 24 ]; then
                echo "${artist:0:22}..."
            else
                echo "$artist"
            fi
        else
            echo "Offline"
        fi
        ;;
    status)
        playerctl --player="$PLAYER" status 2>/dev/null || echo "Stopped"
        ;;
    icon)
        status=$(playerctl --player="$PLAYER" status 2>/dev/null)
        if [ "$status" = "Playing" ]; then
            echo "󰏤"
        else
            echo "󰐊"
        fi
        ;;
    cover)
        art_url=$(playerctl --player="$PLAYER" metadata --format "{{mpris:artUrl}}" 2>/dev/null)
        if [ -n "$art_url" ]; then
            if [[ "$art_url" =~ ^file://(.*) ]]; then
                file_path="${BASH_REMATCH[1]}"
                if [ -f "$file_path" ]; then
                    cp "$file_path" "$COVER_DEST" 2>/dev/null
                    echo "$COVER_DEST"
                    exit 0
                fi
            elif [[ "$art_url" =~ ^https?:// ]]; then
                # Only download if url changed or file missing
                last_url_file="/tmp/eww_last_cover_url"
                last_url=$(cat "$last_url_file" 2>/dev/null)
                if [ "$last_url" != "$art_url" ] || [ ! -f "$COVER_DEST" ]; then
                    curl -s --max-time 3 "$art_url" -o "$COVER_DEST" 2>/dev/null
                    echo "$art_url" > "$last_url_file"
                fi
                echo "$COVER_DEST"
                exit 0
            fi
        fi
        echo ""
        ;;
    time)
        pos=$(playerctl --player="$PLAYER" position 2>/dev/null | cut -d. -f1)
        len_raw=$(playerctl --player="$PLAYER" metadata mpris:length 2>/dev/null)
        if [ -n "$pos" ] && [ -n "$len_raw" ] && [ "$len_raw" -gt 0 ]; then
            len=$((len_raw / 1000000))
            pos_min=$((pos / 60)); pos_sec=$((pos % 60))
            len_min=$((len / 60)); len_sec=$((len % 60))
            printf "%d:%02d / %d:%02d\n" "$pos_min" "$pos_sec" "$len_min" "$len_sec"
        else
            echo "0:00 / 0:00"
        fi
        ;;
    progress)
        pos=$(playerctl --player="$PLAYER" position 2>/dev/null | cut -d. -f1)
        len_raw=$(playerctl --player="$PLAYER" metadata mpris:length 2>/dev/null)
        if [ -n "$pos" ] && [ -n "$len_raw" ] && [ "$len_raw" -gt 0 ]; then
            len=$((len_raw / 1000000))
            if [ "$len" -gt 0 ]; then
                echo $((pos * 100 / len))
                exit 0
            fi
        fi
        echo "0"
        ;;
    toggle)
        playerctl --player="$PLAYER" play-pause 2>/dev/null
        ;;
    next)
        playerctl --player="$PLAYER" next 2>/dev/null
        ;;
    prev)
        playerctl --player="$PLAYER" previous 2>/dev/null
        ;;
    shuffle)
        shuf=$(playerctl --player="$PLAYER" shuffle 2>/dev/null)
        if [ "$shuf" = "On" ]; then
            echo "active"
        else
            echo "inactive"
        fi
        ;;
    shuffle-toggle)
        shuf=$(playerctl --player="$PLAYER" shuffle 2>/dev/null)
        if [ "$shuf" = "On" ]; then
            playerctl --player="$PLAYER" shuffle Off 2>/dev/null
        else
            playerctl --player="$PLAYER" shuffle On 2>/dev/null
        fi
        ;;
    loop-toggle)
        playerctl --player="$PLAYER" loop playlist 2>/dev/null || playerctl --player="$PLAYER" loop Track 2>/dev/null
        ;;
esac
