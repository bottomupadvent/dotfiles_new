#!/bin/bash
# This script is mapped to a keybinding Ctrl+alt+w in ~/.xbindkeysrc
# Copies current tab URL in google-chrome and open it in w3m
# Script requires xdotool, tmux, google-chrome, xsel

xdotool search --name "google-chrome" key ctrl+l ctrl+c
tmux run-shell "xsel -op > /tmp/webpage_url.chrome" ; tmux load-buffer /tmp/webpage_url.chrome
tmux send-keys -t web:0.1 t o C-u ; tmux paste-buffer -t web:0.1 ; tmux send-keys -t web:0.1 Enter
tmux switch-client -t web:0.1
xdotool key alt+Tab
