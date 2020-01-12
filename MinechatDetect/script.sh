#!/bin/bash
### ### ### Settings ### ### ###

BASE_DIR=???
#Directly that contains the id_rsa file
rsa=???
# Mcrcon login
IP=example.com
port=111
pass=SecretPizza

# SSH Settings
sshHOST=???
sshUSER=Notch
LogFileDir=/path/to/the/latest.log

# While true loop speed.
## NOTE: We need to use a sleep command to prevent the loop from using up CPU.
# Usually, 0.5s is fine
delay=0.5



# http://github.com/jakesta13
### ### ### ### ### ###
if [ ! -f "${BASE_DIR}/latest.log" ]; then
	echo "Creating latest.log"
	touch "${BASE_DIR}/latest.log"
	echo -n "" > "${BASE_DIR}/latest.log"
fi


# https://www.thegeekstuff.com/2009/10/unix-sed-tutorial-how-to-execute-multiple-sed-commands/
# https://unix.stackexchange.com/a/257545
echo "Making new Tmux session named MineChat Sender"
tmux new -d -s MineChatSender '"'"${BASE_DIR}/script.sh"'" "'"${IP}"'" "'"${port}"'" "'"${pass}"'" "'"${mcfunction}"'" "'"${BASE_DIR}"'" "'"${delay}"'"'
ssh -i "${rsa}/id_rsa" "${sshUSER}@${sshHOST}" 'tail -F -n1 ${LogFileDIR} | grep --line-buffered -w "MineChat"' | sed -e 's/.*INFO\]: //1' -e 's/<=\?//' -e 's/>=\?.*//'
