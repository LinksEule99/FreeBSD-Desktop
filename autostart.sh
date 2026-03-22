#!/usr/local/bin/bash

# Start dwm status bar (correct path)
if [ -f ~/.dwm/dwm-status.sh ]; then
    ~/.dwm/dwm-status.sh &
fi

# Keyboard layout
setxkbmap de &

# Wallpaper - check if nitrogen is installed and not already running
if command -v nitrogen >/dev/null 2>&1; then
    nitrogen --restore &
fi

# Compositor - check if picom isn't already running
if command -v picom >/dev/null 2>&1; then
    if ! pgrep -x "picom" > /dev/null; then
        picom --vsync --backend glx &
    fi
fi
