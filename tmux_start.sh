#!/bin/sh

# Session Name
SESSION_NAME=$1

# Window name list
WINDOW_NAMES=('win1' 'win2' 'win3')

# Attach tmux and create tmux tabs
if [ $SESSION_NAME ]; then
    i=0
    while [ $i -lt ${#WINDOW_NAMES[@]} ]
    do
        wid=$i
        echo "tmux new-window -t $SESSION_NAME:$i -n ${WINDOW_NAMES[$i]}"
        if [ $wid -le 0 ]; then
            tmux new-session -s "$SESSION_NAME" -d -n "${WINDOW_NAMES[$i]}"
            echo "Attached tmux!"
        else
            tmux new-window -d -k -t "$SESSION_NAME:$i" -n "${WINDOW_NAMES[$i]}"
        fi
        i=`expr $i + 1`
        sleep 1s
    done

    tmux attach-session -t "$SESSION_NAME"
else
    echo "Usage: # sh tmux_start.sh session_name"
fi
