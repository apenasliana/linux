#!/bin/bash

# Primary monitor
PRIMARY="DP-2"
SECONDARY="DP-4"

# Target resolution and refresh rate
TARGET_RES="1920x1080"
TARGET_RATE="144.00"

# Check if DP-4 is connected
if xrandr | grep -q "$SECONDARY connected"; then
    echo "$SECONDARY is connected. Configuring dual monitors..."

    # Get the best available refresh rate (prioritize 144Hz)
    get_best_rate() {
        local monitor="$1"
        local rate=$(xrandr | grep -A 10 "$monitor connected" | grep "$TARGET_RES" | awk '{print $NF}' | grep -o '[0-9.]\+' | sort -nr | head -n 1)
        
        # Prefer 144Hz, else fall back to highest available
        if xrandr | grep -A 10 "$monitor connected" | grep "$TARGET_RES" | grep -q "$TARGET_RATE"; then
            echo "$TARGET_RATE"
        else
            echo "$rate"
        fi
    }

    # Get refresh rates for both monitors
    RATE_PRIMARY=$(get_best_rate "$PRIMARY")
    RATE_SECONDARY=$(get_best_rate "$SECONDARY")

    echo "Setting $PRIMARY to $TARGET_RES @ $RATE_PRIMARY Hz (primary)"
    echo "Setting $SECONDARY to $TARGET_RES @ $RATE_SECONDARY Hz (above $PRIMARY)"

    # Apply settings
    xrandr --output "$PRIMARY" --mode "$TARGET_RES" --rate "$RATE_PRIMARY" --primary --pos 0x1080 \
           --output "$SECONDARY" --mode "$TARGET_RES" --rate "$RATE_SECONDARY" --above "$PRIMARY" --pos 0x0

    echo "Dual monitors configured!"
else
    echo "$SECONDARY not connected. Using single monitor ($PRIMARY)."
    xrandr --output "$PRIMARY" --auto --primary --output "$SECONDARY" --off
fi