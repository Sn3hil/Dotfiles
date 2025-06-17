#!/usr/bin/env bash

# Toggle DroidCam on/off based on running status

if pgrep -x "droidcam-cli" > /dev/null || pgrep -x "droidcam" > /dev/null; then
    pkill -x droidcam-cli
    pkill -x droidcam
else
    # Connect via the existing script (renamed from search -> launch)
    /home/kshiyo/.config/waybar/scripts/droidcam-launch.sh &
fi

