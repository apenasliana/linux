#!/usr/bin/env bash

killall -q polybar
polybar-msg cmd quit

polybar-msg cmd quit

if type "xrandr"; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload mybar &
  done
else
  polybar --reload mybar &
fi
echo "Bars launched..."

# #!/usr/bin/env bash

# # Terminate already running bar instances
# # If all your bars have ipc enabled, you can use 
# polybar-msg cmd quit
# # Otherwise you can use the nuclear option:
# # killall -q polybar

# # Launch bar1 and bar2
# echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
# polybar bar1 2>&1 | tee -a /tmp/polybar1.log & disown
# polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

# echo "Bars launched..."