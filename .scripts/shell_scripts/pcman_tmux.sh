#!/usr/bin/bash

var=$(pwd)
dolphin "$var" 2> /dev/null &
disown
xdotool key alt+2 &
