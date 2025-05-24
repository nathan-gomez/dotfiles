#!/usr/bin/env bash

# Terminate already running bar instances
# If all your bars have ipc enabled, you can use
polybar-msg cmd quit
# Otherwise you can use the nuclear option:
# killall -q polybar

# Launch bar1 and bar2
echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log
polybar taskbar 2>&1 -r | tee -a /tmp/polybar-taskbar.log & disown
# polybar topbar 2>&1 -r | tee -a /tmp/polybar-topbar.log & disown

echo "Polybar launched..."
