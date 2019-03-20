#!/usr/bin/env bash

# Terminate any currently running instances
killall -q polybar

# Pause while killall completes
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar(s)
polybar top -q &
polybar bottom -q  &

echo "polybars launched..."
