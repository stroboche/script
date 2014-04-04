#!/bin/sh

# Session Name
SESSION_NAME=$1

# Window name list
WINDOW_NAMES=('win1' 'win2' 'win3')

# Attach screen and create screen tabs
if [ $SESSION_NAME ]; then
    i=0
    while [ $i -lt ${#WINDOW_NAMES[@]} ]
    do
        wid=$i
        echo "screen[$wid]: ${WINDOW_NAMES[$wid]}"
        if [ $wid -le 0 ] ; then
            screen -d -m -S $SESSION_NAME -p $wid -t ${WINDOW_NAMES[$wid]}
            echo "Attached screen!"
        else
            screen -X -S $SESSION_NAME screen -t ${WINDOW_NAMES[$wid]} $wid
        fi
        i=`expr $i + 1`
        sleep 1s
    done

    screen -d -r $SESSION_NAME -p 0
else
    echo "Usage: # sh screen_start.sh session_name"
fi

