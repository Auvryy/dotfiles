#!/usr/bin/env bash
# =============================================================================
# GPU Screen Recorder Controller Script for Eww
# Hardware accelerated screen recording & instant replay controller
# =============================================================================

ACTION="$1"
RECORD_DIR="$HOME/Videos"
TIME_FILE="/tmp/eww_gsr_start_time"
MIC_FILE="/tmp/eww_gsr_mic"

mkdir -p "$RECORD_DIR"

# Detect current status
get_status() {
    local pid
    pid=$(pgrep -f "gpu-screen-recorder -w" 2>/dev/null | head -n 1)
    if [ -z "$pid" ]; then
        echo "idle"
        return
    fi
    local cmd
    cmd=$(tr '\0' ' ' < "/proc/$pid/cmdline" 2>/dev/null)
    if echo "$cmd" | grep -q -- "-r "; then
        echo "replay"
    else
        echo "recording"
    fi
}

get_elapsed_time() {
    local status
    status=$(get_status)
    if [ "$status" != "recording" ]; then
        echo "00:00"
        return
    fi
    if [ ! -f "$TIME_FILE" ]; then
        echo "00:00"
        return
    fi
    local start
    start=$(cat "$TIME_FILE" 2>/dev/null || date +%s)
    local now
    now=$(date +%s)
    local diff=$((now - start))
    if [ "$diff" -lt 0 ]; then diff=0; fi
    local mins=$((diff / 60))
    local secs=$((diff % 60))
    printf "%02d:%02d\n" "$mins" "$secs"
}

get_mic_state() {
    if [ -f "$MIC_FILE" ] && [ "$(cat "$MIC_FILE")" = "on" ]; then
        echo "on"
    else
        echo "off"
    fi
}

start_recording() {
    date +%s > "$TIME_FILE"
    local audio="default_output"
    if [ "$(get_mic_state)" = "on" ]; then
        audio="default_output|default_input"
    fi
    local outfile="$RECORD_DIR/Recording_$(date +%Y-%m-%d_%H-%M-%S).mp4"
    nohup gpu-screen-recorder -w HDMI-A-1 -f 60 -a "$audio" -q very_high -o "$outfile" >/dev/null 2>&1 &
    notify-send -i media-record -t 2500 "Screen Recorder" "Started recording screen (60 FPS)..."
}

stop_recording() {
    pkill -SIGINT -f "gpu-screen-recorder -w" 2>/dev/null
    rm -f "$TIME_FILE"
    notify-send -i video-x-generic -t 3500 "Screen Recorder" "Recording saved to ~/Videos"
}

start_replay() {
    local audio="default_output"
    if [ "$(get_mic_state)" = "on" ]; then
        audio="default_output|default_input"
    fi
    nohup gpu-screen-recorder -w HDMI-A-1 -c mp4 -f 60 -a "$audio" -q very_high -r 60 -o "$RECORD_DIR" >/dev/null 2>&1 &
    notify-send -i media-playback-start -t 2500 "Screen Recorder" "Replay buffer active (60s buffer)"
}

stop_replay() {
    pkill -SIGINT -f "gpu-screen-recorder -w" 2>/dev/null
    notify-send -i media-playback-stop -t 2000 "Screen Recorder" "Replay buffer stopped"
}

case "$ACTION" in
    "status")
        get_status
        ;;
    "status-text")
        case $(get_status) in
            "recording") echo "RECORDING" ;;
            "replay")    echo "REPLAY ACTIVE" ;;
            *)           echo "READY" ;;
        esac
        ;;
    "status-icon")
        case $(get_status) in
            "recording") echo "󰑋" ;;
            "replay")    echo "󰓎" ;;
            *)           echo "󰑊" ;;
        esac
        ;;
    "timer")
        get_elapsed_time
        ;;
    "mic")
        get_mic_state
        ;;
    "mic-icon")
        if [ "$(get_mic_state)" = "on" ]; then
            echo "󰍬"
        else
            echo "󰍭"
        fi
        ;;
    "mic-toggle")
        if [ "$(get_mic_state)" = "on" ]; then
            echo "off" > "$MIC_FILE"
            notify-send -i audio-input-microphone -t 2000 "Screen Recorder" "Microphone capture: OFF"
        else
            echo "on" > "$MIC_FILE"
            notify-send -i audio-input-microphone -t 2000 "Screen Recorder" "Microphone capture: ON"
        fi
        ;;
    "toggle-record")
        status=$(get_status)
        if [ "$status" = "recording" ]; then
            stop_recording
        elif [ "$status" = "replay" ]; then
            stop_replay
            sleep 0.5
            start_recording
        else
            start_recording
        fi
        ;;
    "toggle-replay")
        status=$(get_status)
        if [ "$status" = "replay" ]; then
            stop_replay
        elif [ "$status" = "recording" ]; then
            notify-send -i dialog-warning -t 2500 "Screen Recorder" "Cannot start replay while recording"
        else
            start_replay
        fi
        ;;
    "save-replay")
        status=$(get_status)
        if [ "$status" = "replay" ]; then
            pkill -SIGUSR1 -f "gpu-screen-recorder -w" 2>/dev/null
            notify-send -i document-save -t 3000 "Screen Recorder" "Replay clip saved to ~/Videos!"
        else
            notify-send -i dialog-warning -t 2500 "Screen Recorder" "Replay buffer is not currently running"
        fi
        ;;
    "open-videos")
        xdg-open "$RECORD_DIR" 2>/dev/null &
        ;;
    "open-gui")
        gpu-screen-recorder-gtk 2>/dev/null &
        ;;
    "latest-clip")
        latest=$(ls -t "$RECORD_DIR"/*.mp4 2>/dev/null | head -n 1)
        if [ -n "$latest" ]; then
            basename "$latest" | sed 's/\.mp4$//'
        else
            echo "No clips yet"
        fi
        ;;
    "play-latest")
        latest=$(ls -t "$RECORD_DIR"/*.mp4 2>/dev/null | head -n 1)
        if [ -n "$latest" ]; then
            xdg-open "$latest" 2>/dev/null &
        fi
        ;;
    *)
        echo "Usage: $0 {status|status-text|status-icon|timer|mic|mic-icon|mic-toggle|toggle-record|toggle-replay|save-replay|open-videos|open-gui|latest-clip|play-latest}"
        ;;
esac
