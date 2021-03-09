#!/bin/bash

xdotool search "Mozilla Firefox" windowactivate --sync key --clearmodifiers ctrl+l ctrl+c
tmux run-shell "xsel -op > /tmp/webpage_url.chrome" ; tmux load-buffer /tmp/webpage_url.chrome
tmux switch-client -t web:0.1
tmux send-keys -t web:0.1 t o C-u ; tmux paste-buffer -t web:0.1 ; tmux send-keys -t web:0.1 Enter
xdotool key --clearmodifiers alt+Tab
