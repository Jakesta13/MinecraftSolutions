#!/bin/bash
### ### ### Settings ### ### ###
# Enter the base dir where all the scripts reside ... you will need to do this for all.
BASE_DIR=.
# You shouldn't really need to alter anything else below, unless you want to customize the
# initial Tmux screen name.
tmux_name1=LogGrabber


# http://github.com/jakesta13
### ### ### ### ### ###

tmux new -d -s "${tmux_name1}" "unbuffer ${BASE_DIR}/script.sh > latest.log"
