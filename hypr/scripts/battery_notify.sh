#!/usr/bin/env bash

# Threshold (change as you like)
THRESHOLD=20

while true; do
    # Get battery percentage (for most systems)
    BATTERY=$(cat /sys/class/power_supply/BAT*/capacity)

    if [ "$BATTERY" -lt "$THRESHOLD" ]; then
        notify-send "⚠️ Low Battery" "Battery is at ${BATTERY}%!" -i /home/khanal/.config/hypr/icons/low-battery.png
    fi

    # Check every 5 minutes
    sleep 300
done

