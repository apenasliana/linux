#!/bin/bash

# Wacom Configuration Tool v2
# Supports device selection by both ID and name

# Color codes for formatting
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Detect and list available Wacom devices with both ID and name
list_devices() {
    echo -e "\n${YELLOW}Available Wacom devices:${NC}"
    echo "------------------------------------------------"
    
    # List using xsetwacom (shows names)
    xsetwacom --list devices | while read -r line; do
        id=$(echo "$line" | awk '{print $8}')
        name=$(echo "$line" | cut -d' ' -f1-7)
        type=$(echo "$line" | awk '{print $NF}')
        echo -e "[ID: ${GREEN}$id${NC}] ${name} (${YELLOW}$type${NC})"
    done
    
    echo "------------------------------------------------"
}

# Get device name from ID
get_device_name() {
    local id=$1
    xsetwacom --list devices | awk -v id="$id" '$8 == id {print $1,$2,$3,$4,$5,$6,$7,$8,$9}' | head -n1
}

# Get device ID from name
get_device_id() {
    local name=$1
    xsetwacom --list devices | grep -i "$name" | awk '{print $8}' | head -n1
}

# Select a device (either by ID or name)
select_device() {
    local prompt=$1
    list_devices
    
    while true; do
        echo -ne "${YELLOW}$prompt (enter ID or name): ${NC}"
        read input
        
        # Check if input is numeric (assume it's an ID)
        if [[ "$input" =~ ^[0-9]+$ ]]; then
            device_name=$(get_device_name "$input")
            if [ -z "$device_name" ]; then
                echo -e "${RED}Error: No device found with ID $input${NC}"
            else
                device_id="$input"
                echo -e "Selected: ${GREEN}$device_name${NC} (ID: ${YELLOW}$device_id${NC})"
                break
            fi
        else
            # Input is not numeric, treat as name
            device_id=$(get_device_id "$input")
            if [ -z "$device_id" ]; then
                echo -e "${RED}Error: No device found matching '$input'${NC}"
            else
                device_name=$(get_device_name "$device_id")
                echo -e "Selected: ${GREEN}$device_name${NC} (ID: ${YELLOW}$device_id${NC})"
                break
            fi
        fi
    done
}

# List available displays
list_displays() {
    echo -e "\n${YELLOW}Available displays:${NC}"
    xrandr | grep " connected" | awk '{print $1}'
}

# Map device to display
map_to_display() {
    clear
    echo -e "=== ${YELLOW}Map Device to Display${NC} ==="
    select_device "Select device to map"
    
    list_displays
    echo -ne "${YELLOW}Enter display name (e.g., HDMI-1): ${NC}"
    read display_name
    
    # Check if display exists
    if ! xrandr | grep -q "$display_name connected"; then
        echo -e "${RED}Error: Display $display_name not found or not connected.${NC}"
        sleep 2
        return
    fi
    
    echo -e "\nMapping ${GREEN}$device_name${NC} to ${YELLOW}$display_name${NC}"
    xsetwacom set "$device_name" MapToOutput "$display_name"
    
    echo -e "${GREEN}Done!${NC}"
    sleep 2
}

# Set pressure curve
set_pressure() {
    clear
    echo -e "=== ${YELLOW}Set Pressure Sensitivity Curve${NC} ==="
    select_device "Select device for pressure adjustment"
    
    echo -e "\nPressure curve format: ${YELLOW}x1 y1 x2 y2${NC} (values 0-100)"
    echo "Example curves:"
    echo "1. Linear: 0 0 100 100"
    echo "2. Soft start: 5 0 100 95"
    echo "3. Firm: 0 0 20 80"
    echo -ne "${YELLOW}Enter pressure curve values: ${NC}"
    read x1 y1 x2 y2
    
    xsetwacom set "$device_name" PressureCurve "$x1" "$y1" "$x2" "$y2"
    echo -e "${GREEN}Pressure curve set to $x1 $y1 $x2 $y2${NC}"
    sleep 2
}

# Rotate device
rotate_device() {
    clear
    echo -e "=== ${YELLOW}Rotate Device Orientation${NC} ==="
    select_device "Select device to rotate"
    
    echo -e "\n${YELLOW}Orientation options:${NC}"
    echo "1. None (0)"
    echo "2. Clockwise (1)"
    echo "3. Inverted (2)"
    echo "4. Counter-clockwise (3)"
    echo -ne "${YELLOW}Select orientation [1-4]: ${NC}"
    read choice
    
    case $choice in
        1) rot=0 ;;
        2) rot=1 ;;
        3) rot=2 ;;
        4) rot=3 ;;
        *) echo -e "${RED}Invalid option${NC}"; sleep 1; return ;;
    esac
    
    xsetwacom set "$device_name" Rotate "$rot"
    echo -e "${GREEN}Rotation set to $rot${NC}"
    sleep 2
}

# Toggle device
toggle_device() {
    clear
    echo -e "=== ${YELLOW}Toggle Device On/Off${NC} ==="
    select_device "Select device to toggle"
    
    current_state=$(xinput list-props $device_id | grep "Device Enabled" | awk '{print $4}')
    
    if [ "$current_state" -eq 1 ]; then
        xinput disable $device_id
        echo -e "${GREEN}Device $device_id (${device_name}) disabled${NC}"
    else
        xinput enable $device_id
        echo -e "${GREEN}Device $device_id (${device_name}) enabled${NC}"
    fi
    sleep 2
}

# Set custom area
set_custom_area() {
    clear
    echo -e "=== ${YELLOW}Set Custom Tablet Area${NC} ==="
    select_device "Select device for area adjustment"
    
    echo -e "\n${YELLOW}Current tablet area:${NC}"
    xsetwacom get "$device_name" Area
    
    echo -ne "${YELLOW}Enter new area (x1 y1 x2 y2): ${NC}"
    read x1 y1 x2 y2
    
    xsetwacom set "$device_name" Area $x1 $y1 $x2 $y2
    echo -e "${GREEN}New area set to $x1 $y1 $x2 $y2${NC}"
    sleep 2
}

# Reset all devices
reset_devices() {
    clear
    echo -e "=== ${YELLOW}Reset All Wacom Devices${NC} ==="
    list_devices
    echo -e "\nThis will reset ${RED}all${NC} Wacom devices to default settings."
    echo -ne "${YELLOW}Are you sure? [y/N]: ${NC}"
    read confirm
    
    if [ "$confirm" = "y" ] || [ "$confirm" = "Y" ]; then
        xsetwacom --list devices | while read -r line; do
            device=$(echo "$line" | cut -d' ' -f1-7)
            xsetwacom set "$device" ResetArea
            xsetwacom set "$device" Rotate none
            xsetwacom set "$device" PressureCurve 0 0 100 100
            echo -e "Reset ${GREEN}$device${NC}"
        done
        echo -e "${GREEN}All Wacom devices have been reset to defaults.${NC}"
    else
        echo -e "${YELLOW}Operation cancelled.${NC}"
    fi
    sleep 2
}

# Main menu
main_menu() {
    clear
    echo -e "${GREEN}====================================${NC}"
    echo -e "      ${YELLOW}Wacom Device Configuration${NC}     "
    echo -e "${GREEN}====================================${NC}"
    echo -e "\n${YELLOW}Main Menu:${NC}"
    echo "1. Map device to display"
    echo "2. Set pressure sensitivity curve"
    echo "3. Rotate device orientation"
    echo "4. Toggle device on/off"
    echo "5. Set custom area"
    echo "6. Reset all Wacom devices to defaults"
    echo "7. Exit"
    echo -ne "${YELLOW}Select an option [1-7]: ${NC}"
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
        7) echo -e "${GREEN}Exiting...${NC}"; exit 0 ;;
        *) echo -e "${RED}Invalid option${NC}"; sleep 1 ;;
    esac
done