#!/usr/bin/env bash

polybar-msg cmd quit

echo "---" | tee -a /tmp/polybar1.log /tmp/polybar2.log

for m in $(polybar --list-monitors | cut -d":" -f1); do
  MONITOR=$m polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown
done

#polybar example 2>&1 | tee -a /tmp/polybar1.log & disown
#polybar bar2 2>&1 | tee -a /tmp/polybar2.log & disown

echo "Bars launched..."
