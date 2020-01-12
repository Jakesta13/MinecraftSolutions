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

# http://github.com/jakesta13
### ### ### ### ### ###

# https://www.thegeekstuff.com/2009/10/unix-sed-tutorial-how-to-execute-multiple-sed-commands/
# https://unix.stackexchange.com/a/257545
tmux new -d -s MineChatSender '"'"${BASE_DIR}/script.sh"'" "'"${IP}"'" "'"${port}"'" "'"${pass}"'" "'"${mcfunction}"'" "'"${BASE_DIR}"'"'
ssh -i "${rsa}/id_rsa" "${sshUSER}@${sshHOST}" 'tail -F -n1 ${LogFileDIR} | grep --line-buffered -w "MineChat"' | sed -e 's/.*INFO\]: //1' -e 's/<=\?//' -e 's/>=\?.*//'
