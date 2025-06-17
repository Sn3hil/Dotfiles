#!/usr/bin/env bash

# Connects DroidCam once (USB first, then WiFi)
# Does not echo anything, just performs connection

NETWORK_PREFIX="" #ip
PORT="" #port
TIMEOUT=1
LAST_IP_FILE="/tmp/droidcam_last_ip"

test_connection() {
    local ip=$1
    timeout $TIMEOUT nc -z "$ip" "$PORT" 2>/dev/null
}

scan_for_devices() {
    local found_ip=""
    if [[ -f "$LAST_IP_FILE" ]]; then
        last_ip=$(cat "$LAST_IP_FILE")
        if test_connection "$last_ip"; then
            found_ip="$last_ip"
        fi
    fi

    if [[ -z "$found_ip" ]] && test_connection "${NETWORK_PREFIX}.122"; then
        found_ip="${NETWORK_PREFIX}.122"
    fi

    if [[ -z "$found_ip" ]]; then
        common_ips=(100 101 102 103 110 111 112 113 120 121 123 124 125 130 131 132 150 151 152)
        for ip_suffix in "${common_ips[@]}"; do
            ip="${NETWORK_PREFIX}.${ip_suffix}"
            if [[ "$ip" != "${NETWORK_PREFIX}.122" ]] && test_connection "$ip"; then
                found_ip="$ip"
                break
            fi
        done
    fi
    echo "$found_ip"
}

connect_droidcam() {
    local ip=$1
    if adb devices | grep -q "device$"; then
        droidcam-cli adb <port no. here> &
    elif [[ -n "$ip" ]]; then
        echo "$ip" > "$LAST_IP_FILE"
        droidcam-cli "$ip" <port no. here> &
    else
        exit 1
    fi
}

found_ip=$(scan_for_devices)
connect_droidcam "$found_ip"

