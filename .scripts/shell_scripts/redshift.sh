#!/bin/bash

red=$(echo "Enter value between 1000-6500" | dmenu)

if [[ $red =~ [0-9].* ]]; then {
    redshift -P -O "$red"
}
else {
    echo "Enter value between valid range" | dmenu
}
fi
    


