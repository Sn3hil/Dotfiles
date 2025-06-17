#!/usr/bin/env bash

# Check if DroidCam is active by checking for its video device or process
if pgrep -x "droidcam-cli" > /dev/null; then
    echo "󰶷" # Camera active icon
else
    echo "󱦿"  # Camera off icon
fi

