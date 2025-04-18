#!/bin/bash

# Wacom Configuration Tool
# A user-friendly interface for configuring Wacom devices

# Detect available Wacom devices
detect_devices() {
    devices=$(xsetwacom --list devices)
    if [ -z "$devices" ]; then
        echo "No Wacom devices detected."
        exit 1
    fi
    echo -e "\nDetected Wacom devices:"
    echo "$devices"
}

# List available displays
list_displays() {
    echo -e "\nAvailable displays:"
    xrandr | grep " connected" | awk '{print $1}'
}

# Main menu
main_menu() {
    clear
    echo "===================================="
    echo "      Wacom Device Configuration     "
    echo "===================================="
    detect_devices
    echo -e "\nMain Menu:"
    echo "1. Map device to display"
    echo "2. Set pressure sensitivity curve"
    echo "3. Rotate device orientation"
    echo "4. Toggle device on/off"
    echo "5. Set custom area"
    echo "6. Reset all Wacom devices to defaults"
    echo "7. Exit"
    echo -n "Select an option [1-7]: "
}

# Map device to display
map_to_display() {
    clear
    echo "=== Map Device to Display ==="
    detect_devices
    echo -n "Enter device name (e.g., 'Wacom One by Wacom M Pen stylus'): "
    read device_name
    
    list_displays
    echo -n "Enter display name (e.g., HDMI-1): "
    read display_name
    
    # Check if display exists
    if ! xrandr | grep -q "$display_name connected"; then
        echo "Error: Display $display_name not found or not connected."
        return
    fi
    
    # Get display resolution and offset
    display_info=$(xrandr | grep -A1 "$display_name connected" | tail -n1)
    resolution=$(echo "$display_info" | awk '{print $1}')
    offset=$(echo "$display_info" | awk '{print $3}')
    
    echo "Mapping $device_name to $display_name ($resolution at $offset)"
    xsetwacom set "$device_name" MapToOutput "$display_name"
    echo "Done!"
    sleep 2
}

# Set pressure curve
set_pressure() {
    clear
    echo "=== Set Pressure Sensitivity Curve ==="
    detect_devices
    echo -n "Enter device name: "
    read device_name
    
    echo -e "\nPressure curve format: x1 y1 x2 y2 (values 0-100)"
    echo "Example curves:"
    echo "1. Soft: 0 0 100 100"
    echo "2. Firm: 5 0 100 95"
    echo "3. Hard: 0 0 20 80"
    echo -n "Enter pressure curve values: "
    read x1 y1 x2 y2
    
    xsetwacom set "$device_name" PressureCurve "$x1" "$y1" "$x2" "$y2"
    echo "Pressure curve set to $x1 $y1 $x2 $y2"
    sleep 2
}

# Rotate device
rotate_device() {
    clear
    echo "=== Rotate Device Orientation ==="
    detect_devices
    echo -n "Enter device name: "
    read device_name
    
    echo -e "\nOrientation options:"
    echo "1. None (0)"
    echo "2. Clockwise (1)"
    echo "3. Inverted (2)"
    echo "4. Counter-clockwise (3)"
    echo -n "Select orientation [1-4]: "
    read choice
    
    case $choice in
        1) rot=0 ;;
        2) rot=1 ;;
        3) rot=2 ;;
        4) rot=3 ;;
        *) echo "Invalid option"; return ;;
    esac
    
    xsetwacom set "$device_name" Rotate "$rot"
    echo "Rotation set to $rot"
    sleep 2
}

# Toggle device
toggle_device() {
    clear
    echo "=== Toggle Device On/Off ==="
    devices=$(xinput --list | grep -i "wacom" | grep -i "stylus\|eraser\|pad")
    echo -e "\nDetected Wacom devices:"
    echo "$devices"
    
    echo -n "Enter device ID to toggle: "
    read device_id
    
    current_state=$(xinput list-props $device_id | grep "Device Enabled" | awk '{print $4}')
    
    if [ "$current_state" -eq 1 ]; then
        xinput disable $device_id
        echo "Device $device_id disabled"
    else
        xinput enable $device_id
        echo "Device $device_id enabled"
    fi
    sleep 2
}

# Set custom area
set_custom_area() {
    clear
    echo "=== Set Custom Tablet Area ==="
    detect_devices
    echo -n "Enter device name: "
    read device_name
    
    echo -e "\nCurrent tablet area:"
    xsetwacom get "$device_name" Area
    
    echo -n "Enter new area (x1 y1 x2 y2): "
    read x1 y1 x2 y2
    
    xsetwacom set "$device_name" Area $x1 $y1 $x2 $y2
    echo "New area set to $x1 $y1 $x2 $y2"
    sleep 2
}

# Reset all devices
reset_devices() {
    clear
    echo "=== Reset All Wacom Devices ==="
    detect_devices
    echo -e "\nThis will reset all Wacom devices to default settings."
    echo -n "Are you sure? [y/N]: "
    read confirm
    
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        for device in $(xsetwacom --list devices | awk '{print $1,$2,$3,$4,$5,$6,$7,$8,$9}'); do
            xsetwacom set "$device" ResetArea
            xsetwacom set "$device" Rotate none
            xsetwacom set "$device" PressureCurve 0 0 100 100
            echo "Reset $device"
        done
        echo "All Wacom devices have been reset to defaults."
    else
        echo "Operation cancelled."
    fi
    sleep 2
}

# Main loop
while true; do
    main_menu
    read choice
    case $choice in
        1) map_to_display ;;
        2) set_pressure ;;
        3) rotate_device ;;
        4) toggle_device ;;
        5) set_custom_area ;;
        6) reset_devices ;;
        7) echo "Exiting..."; exit 0 ;;
        *) echo "Invalid option"; sleep 1 ;;
    esac
done