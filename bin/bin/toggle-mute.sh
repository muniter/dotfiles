#!/bin/bash
toggle=$((pactl list sinks | grep -q Mute:.no && echo 1) || echo 0)
pactl set-sink-mute 0 $toggle
pactl set-sink-mute 1 $toggle
pactl set-sink-mute 2 $toggle
pactl set-sink-mute 3 $toggle

