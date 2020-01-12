#!/bin/bash
### ### ### Settings ### ### ###
## Rcon pass-over settings
IP="${1}"
port="${2}"
pass="${3}"

## Function pass-over settings
mcfunction="${4}"

## Directory pass-over settings
dir="${5}"

# While true delay pass-over settings
delay="${6}"

# 2script.sh Requires:
# Script.sh - Part 1, this will give us an output.
# You need to start this script with:
# ' tmux new -d -s MineChat "unbuffer ./script.sh > latest.log" '

# Unbuffer command use found here:
# https://unix.stackexchange.com/a/200413
#   Wasn't used the same way as the answer, but I found it worked for the script above


# http://github.com/jakesta13
### ### ### ### ### ### ###
# https://superuser.com/a/90009
#
while true; do
	while read line; do mcrcon -H "${IP}" -P "${port}" -p "${pass}" "execute as ${line} run function ${mcfunction}"; done < latest.log
	# Moved this to the while true loop, as it can send the rcon command out in bulk rather than one at a time.
	echo "" -n > "${dir}/latest.log"
	sleep ${delay}
	done
