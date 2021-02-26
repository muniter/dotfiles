#!/usr/bin/env sh

# Terminate already running bar instances
killall -q waybar
pkill -f waybar-data-getter.sh

# Wait until the processes have been shut down
while pgrep -x waybar >/dev/null; do sleep 1; done

# Data getter
# ./waybar-data-getter.sh
# Launch main
waybar
