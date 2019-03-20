#!/usr/bin/env bash

# Terminate any currently running instances
killall -q polybar

# Pause while killall completes
while pgrep -u $UID -x polybar > /dev/null; do sleep 1; done

if type "xrandr" > /dev/null; then
  for m in $(xrandr --query | grep " connected" | cut -d" " -f1); do
    MONITOR=$m polybar --reload dummy -c ~/.config/polybar/config &
    MONITOR=$m polybar --reload top -c ~/.config/polybar/config &
#    MONITOR=$m polybar --reload bottom -c ~/.config/polybar/config &
  done
else
  polybar --reload top -c ~/.config/polybar/config &
fi

# Launch bar(s)
# polybar dummy -q &
# polybar top -q &
# polybar bottom -q  &

echo "polybars launched..."
