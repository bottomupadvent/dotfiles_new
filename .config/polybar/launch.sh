#!/usr/bin/env sh

# Terminate already running bar instances
killall -q polybar

# Wait until the processes have been shut down
while pgrep -x polybar >/dev/null; do sleep 1; done

# Launch bar1 and bar2
polybar -r --log=notice white &

echo "Bars launched..."

xbindkeys --poll-rc # This is temporary command. Add it to startup file
