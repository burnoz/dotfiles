#!/bin/bash
DEVICE="type:touch"

STATUS=$(swaymsg -t get_inputs | jq -r ".[] | select(.type==\"touch\") | .libinput.send_events" | head -n 1)

if [ "$STATUS" = "enabled" ]; then
    swaymsg input "$DEVICE" events disabled
else
    swaymsg input "$DEVICE" events enabled
fi
