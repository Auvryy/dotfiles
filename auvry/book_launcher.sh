#!/usr/bin/env bash
if pidof rofi > /dev/null; then
    pkill rofi
    exit 0
fi

books_dir="$HOME/Documents/003-Books"

selected=$(find "$books_dir" -type f -iname "*.pdf" -o -iname "*.epub" -o -iname "*.djvu" 2>/dev/null \
    | sed "s|$books_dir/||" \
    | rofi -dmenu -p "󰂿  Books" -i -sort -sorting-method fzf -placeholder "Search books...")

[[ -z "$selected" ]] && exit 0

zathura "$books_dir/$selected" &
