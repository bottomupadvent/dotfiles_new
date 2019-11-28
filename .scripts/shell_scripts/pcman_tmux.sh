#!/usr/bin/bash

var=$(pwd)
proc=$(pgrep pcmanfm)
if [[ $proc =~ "[0-9].*" ]]; then
    pcmanfm "$var" 2> /dev/null &
    disown
    i3-msg -t run_command workspace "5"
else
    i3-msg -t run_command workspace "5"
    pcmanfm "$var" 2> /dev/null &
    disown
fi
