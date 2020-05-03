#!/bin/sh

# still testing this
tmux new-window 'echo 1'
tmux split-window -h 'pwd'
tmux split-window -v 'pwd'
tmux new-window 'echo 2'
tmux split-window -h 'pwd'
tmux split-window -v 'pwd'
tmux new-window 'echo 3'
tmux split-window -h 'pwd'
tmux split-window -v 'pwd'