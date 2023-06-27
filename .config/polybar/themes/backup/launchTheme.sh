#!/usr/bin/env bash
THEME="main"

# Terminate already-running bar instances
killall -q polybar

# Wait until the processes have been shutdown
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done

CONFIG_DIR=$(dirname $0)/themes/$THEME/config.ini

# Get network interface name
export NETWORK_INTERFACE=$(ip link show | grep "state UP" | head -n 1 | cut -d" " -f2 | cut -d":" -f1)

# Get CPU thermal zone
export THERMAL_ZONE=$(ls /sys/class/thermal | grep thermal_zone | grep -oE "[0-9]" | sort -nr | head -n 1)

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m NETWORK_INTERFACE=$NETWORK_INTERFACE THERMAL_ZONE=$THERMAL_ZONE polybar --reload $THEME -c $CONFIG_DIR  &
  done
else
  polybar $THEME -c $CONFIG_DIR &

fi
echo "Bars launched..."