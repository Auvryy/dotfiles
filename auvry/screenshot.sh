#!/usr/bin/env bash
# ==============================================================================
# Screenshot Utility for Hyprland with Dynamic Monthly Folders & Rename Prompt
# ==============================================================================

MODE="${1:-region}"
BASE_DIR="$HOME/Pictures/Screenshots"
TEMP_FILE="/tmp/screenshot_$(date +%s%N).png"

# Ensure cleanup on exit
cleanup() {
    [ -f "$TEMP_FILE" ] && rm -f "$TEMP_FILE"
}
trap cleanup EXIT

# ------------------------------------------------------------------------------
# 1. Determine / Auto-create Dynamic Monthly Folder (e.g. 001-Sept-2026)
# ------------------------------------------------------------------------------
mkdir -p "$BASE_DIR"

MONTH_NUM=$(date +%m)
YEAR=$(date +%Y)

case "$MONTH_NUM" in
    01) MONTH_STR="Jan" ;;
    02) MONTH_STR="Feb" ;;
    03) MONTH_STR="Mar" ;;
    04) MONTH_STR="Apr" ;;
    05) MONTH_STR="May" ;;
    06) MONTH_STR="Jun" ;;
    07) MONTH_STR="Jul" ;;
    08) MONTH_STR="Aug" ;;
    09) MONTH_STR="Sept" ;;
    10) MONTH_STR="Oct" ;;
    11) MONTH_STR="Nov" ;;
    12) MONTH_STR="Dec" ;;
esac

TARGET_DIR=""
for d in "$BASE_DIR"/*-${MONTH_STR}-${YEAR} "$BASE_DIR"/*-Sep-${YEAR}; do
    if [ -d "$d" ]; then
        TARGET_DIR="$d"
        break
    fi
done

if [ -z "$TARGET_DIR" ]; then
    MAX_NUM=0
    for d in "$BASE_DIR"/[0-9][0-9][0-9]-*; do
        if [ -d "$d" ]; then
            bname=$(basename "$d")
            pfx="${bname%%-*}"
            if [[ "$pfx" =~ ^[0-9]{3}$ ]]; then
                val=$((10#$pfx))
                if [ "$val" -gt "$MAX_NUM" ]; then
                    MAX_NUM=$val
                fi
            fi
        fi
    done
    NEXT_NUM=$((MAX_NUM + 1))
    PREFIX=$(printf "%03d" "$NEXT_NUM")
    TARGET_DIR="$BASE_DIR/${PREFIX}-${MONTH_STR}-${YEAR}"
    mkdir -p "$TARGET_DIR"
fi

FOLDER_NAME=$(basename "$TARGET_DIR")

# ------------------------------------------------------------------------------
# 2. Capture Screenshot
# ------------------------------------------------------------------------------
case "$MODE" in
    clipboard-region)
        GEOM=$(slurp -d -b 00000044 -c c9beffff -w 2 2>/dev/null)
        [ -z "$GEOM" ] && exit 0
        sleep 0.15
        grim -g "$GEOM" - | wl-copy --type image/png
        notify-send "Screenshot Copied" "Region copied to clipboard." -i camera-photo -a "Screenshot"
        exit 0
        ;;

    clipboard-output)
        grim - | wl-copy --type image/png
        notify-send "Screenshot Copied" "Fullscreen copied to clipboard." -i camera-photo -a "Screenshot"
        exit 0
        ;;

    region)
        GEOM=$(slurp -d -b 00000044 -c c9beffff -w 2 2>/dev/null)
        [ -z "$GEOM" ] && exit 0
        sleep 0.15
        grim -g "$GEOM" "$TEMP_FILE" || exit 1
        ;;

    output)
        grim "$TEMP_FILE" || exit 1
        ;;

    *)
        echo "Usage: $0 {region|output|clipboard-region|clipboard-output}"
        exit 1
        ;;
esac

# Ensure image was successfully captured
if [ ! -s "$TEMP_FILE" ]; then
    exit 0
fi

# ------------------------------------------------------------------------------
# 3. Prompt for Filename via Rofi
# ------------------------------------------------------------------------------
DEFAULT_NAME="screenshot_$(date '+%Y-%m-%d_%H-%M-%S')"
THEME_FILE="$HOME/.config/rofi/screenshot.rasi"

ROFI_CMD=(rofi -dmenu -p "󰄀  Screenshot Name")
if [ -f "$THEME_FILE" ]; then
    ROFI_CMD+=(-theme "$THEME_FILE")
fi
ROFI_CMD+=(-mesg "↵ Save to <b>${FOLDER_NAME}</b> (Default: ${DEFAULT_NAME}.png)  |  Esc Cancel")

USER_INPUT=$(echo "" | "${ROFI_CMD[@]}")
ROFI_STATUS=$?

# If user pressed Escape
if [ $ROFI_STATUS -ne 0 ]; then
    notify-send "Screenshot Cancelled" "Capture discarded." -i dialog-information -a "Screenshot"
    exit 0
fi

# Trim whitespace
USER_INPUT=$(echo "$USER_INPUT" | xargs)

if [ -z "$USER_INPUT" ]; then
    FINAL_NAME="${DEFAULT_NAME}.png"
else
    # Remove existing .png suffix (case-insensitive) and sanitize
    USER_INPUT=$(echo "$USER_INPUT" | sed -E 's/\.png$//I')
    USER_INPUT=$(echo "$USER_INPUT" | tr '/\\' '_')
    FINAL_NAME="${USER_INPUT}.png"
fi

# ------------------------------------------------------------------------------
# 4. Save to Target Folder & Clipboard
# ------------------------------------------------------------------------------
DEST_FILE="$TARGET_DIR/$FINAL_NAME"

# Handle name collisions
if [ -f "$DEST_FILE" ]; then
    base="${FINAL_NAME%.png}"
    counter=1
    while [ -f "$TARGET_DIR/${base}_${counter}.png" ]; do
        counter=$((counter + 1))
    done
    FINAL_NAME="${base}_${counter}.png"
    DEST_FILE="$TARGET_DIR/$FINAL_NAME"
fi

cp "$TEMP_FILE" "$DEST_FILE"
wl-copy --type image/png < "$DEST_FILE"

notify-send "Screenshot Saved" \
    "Saved to <b>${FOLDER_NAME}/${FINAL_NAME}</b>\nCopied to clipboard." \
    -i "$DEST_FILE" \
    -a "Screenshot"
