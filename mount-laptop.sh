#!/usr/bin/env bash

# Usage: mount-laptop.sh <laptop-ip>

IP="$1"
USER="kshiyo"      # change this
REMOTE_PATH="/home/$USER"
MOUNT_POINT="$HOME/EUROPA"

if [ -z "$IP" ]; then
    echo "Usage: $0 <laptop-ip>"
    exit 1
fi

mkdir -p "$MOUNT_POINT"

echo "Mounting $USER@$IP:$REMOTE_PATH to $MOUNT_POINT..."

sshfs -o IdentityFile="$HOME/.ssh/id_ed25519",reconnect,ServerAliveInterval=15,ServerAliveCountMax=3 "$USER@$IP:$REMOTE_PATH" "$MOUNT_POINT"

if [ $? -eq 0 ]; then
    echo "Mount successful!"
else
    echo "Mount failed."
fi
