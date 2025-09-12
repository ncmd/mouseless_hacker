#!/bin/bash
DEVICE="FA:B8:EE:78:B9:0B"

# Ensure controller is powered on
bluetoothctl power on

# Check connection status
if bluetoothctl info "$DEVICE" | grep -q "Connected: yes"; then
    echo "Device $DEVICE is already connected."
else
    echo "Reconnecting to $DEVICE..."
    bluetoothctl connect "$DEVICE"
fi

