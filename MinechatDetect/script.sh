#!/bin/bash

## ## Notice ## ##
# This is part 1 of 2 scritps and the second script, 2script.sh is required
# Please make sure that you have the entire github repo, and double check scritp settings per sh file.
# In the future I may have this script auto download the second part if it is not found.

### ### ### Settings ### ### ###
# Enter the script's DIR
BASE_DIR=.

## Mcrcon settings
IP=???
port=???
pass=???

## Minecraft function settings
# Enter the function to execute as player
# e.g datapackname:dirto/function
mcfunction="example:newfolder/newfunction"

## Tmux screen settings
# Please enter a screen-name for the new Tmux session
tmux_name=LogReacts

## SSH settings
# Host and username
host=???
user=???

# Enter the location to the id_rsa for the SSH host.
rsa=.

# Enter the remote directory of the Minecraft Server's latest.log file
log=/full/path/to/logs/

## Explicit 2script.sh settings
# Speed settings
# This setting its to prevent the while true loop from using
# exessive CPU usage, the delay between the loop is up to you.
# reguardless of the speed, if there are multiple detections, the loop should catch all of them
# and send the commands in sequence of detection and get caught up.
# Speed settngs are in normal sleep format, in seconds.
speed=0.5



# http://github.com/jakesta13
### ### ### ### ### ###
if [ ! -f "${BASE_DIR}/latest.log" ]; then
	echo "creating latest.log"
	touch "${BASE_DIR}/latest.log"
fi



echo "Starting new Tmux session in the background, named ${tmux_name}"
tmux new -d -s "${tmux_name}" '"'"${BASE_DIR}/2script.sh"'" "'"${IP}"'" "'"${port}"'" "'"${pass}"'" "'"${mcfunction}"'" "'"${speed}"'"'
# https://www.thegeekstuff.com/2009/10/unix-sed-tutorial-how-to-execute-multiple-sed-commands/
# https://unix.stackexchange.com/a/257545
ssh -i "${rsa}/id_rsa" "${user}@${host}" "tail -F -n1 ${log}/latest.log | grep --line-buffered -w 'MineChat'" | sed -e 's/.*: //' -e 's/<=\?//' -e 's/>=\?.*//'
