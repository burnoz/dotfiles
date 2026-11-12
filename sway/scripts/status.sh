#!/bin/bash

print_status() {
    RAW=$(wpctl get-volume @DEFAULT_AUDIO_SINK@ 2>/dev/null)
    VOL=$(echo "$RAW" | awk '{printf "%d", $2 * 100}')
    MUTE=$(echo "$RAW" | grep -q "MUTED" && echo " (MUTE)" || echo "")
    DATE=$(date +'%Y-%m-%d %I:%M:%S %p')

    echo "Vol: ${VOL:-0}%${MUTE} | ${DATE}"
}

trap 'print_status' USR1

while true; do
    print_status
    sleep 1 &
    wait $!
done
