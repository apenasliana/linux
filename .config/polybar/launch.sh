#!/usr/bin/env bash
THEME="main"


killall -q polybar
polybar-msg cmd quit

CONFIG_DIR=$(dirname $0)/themes/$THEME/config.ini
while pgrep -u $UID -x polybar >/dev/null; do sleep 1; done



if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar main -c $CONFIG_DIR &
  done
else
  polybar main -c $CONFIG_DIR &

fi
echo "Bars launched..."




