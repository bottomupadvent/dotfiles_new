#!/bin/bash

output=$(pgrep polybar)

if [[ $output =~ [0-9\] ]] ; then
	killall polybar 
else 
	polybar white &
fi



