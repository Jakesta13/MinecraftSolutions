#!/bin/bash
### ### ### Settings ### ### ###
# Enter the BASE DIRECTORY below
BASE_DIR=.

# IFTTT Settings
# IFTTT Applet name
applet=
# IFTTT Key
key=

# Just in the rare case that mojang changes their version_manifest url
version=https://launchermeta.mojang.com/mc/game/version_manifest.json
# Getting manifest json
get=$(curl https://launchermeta.mojang.com/mc/game/version_manifest.json 2>/dev/null)

# https://github.com/jakesta13
### ### ### ### ### ###

## ## ## Setting Variables ## ## ##
Rupdate=n
Supdate=n

# Getting version headder
version=$(echo "${get}" | tr ',' '\n' | grep "latest" -A1)

# Cleaning and separating the versions...
# Cut command below is from https://stackoverflow.com/a/23690727
# 3rd Sed command from https://stackoverflow.com/a/2453056
released=$(echo ${version} | sed 's/^.............//' | cut -f1,2 -d' ' | sed 's/"//g' | sed -r 's/\<./\U&/g')
# 2nd Sed command from https://www.unix.com/302281968-post2.html
# 6th Sed command from https://stackoverflow.com/a/2453056
snapshot=$(echo ${version} | sed 's/^.............//' | sed 's/^.* "s//g' | sed 's/napshot/snapshot/' | sed 's/"//g' | sed 's/}//' | sed -r 's/\<./\U&/g')
## ## ## ## ## ##

# # # Setting files # # #
# checking if Released file exists
if [ ! -e "${BASE_DIR}/Release.txt" ]; then
	touch "${BASE_DIR}/Release.txt"
fi

# Checking if Snapshot file exists
if [ ! -e "${BASE_DIR}/Snapshot.txt" ]; then
	touch "${BASE_DIR}/Snapshot.txt"
fi

# Echoing updates to file
echo ${snapshot} > ${BASE_DIR}/Snapshot.txt
echo ${released} > ${BASE_DIR}/Release.txt



# Checking if md5 files exist
if [ ! -e "${BASE_DIR}/Release.md5" ]; then
	md5sum "${BASE_DIR}/Release.txt" > "${BASE_DIR}/Release.md5"
fi

if [ ! -e "${BASE_DIR}/Snapshot.md5" ]; then
	md5sum "${BASE_DIR}/Snapshot.txt" > "${BASE_DIR}/Snapshot.md5"
fi

# Checking if files are changed (Meaning, new update is released.)
if md5sum -c "${BASE_DIR}/Release.md5" >/dev/null; then
	echo No Released Update
else
	echo New Released Update
	Rupdate=y
	md5sum "${BASE_DIR}/Release.txt" > "${BASE_DIR}/Release.md5"
fi

if md5sum -c "${BASE_DIR}/Snapshot.md5" >/dev/null; then
	echo No Snapshot Update
else
	echo New Snapshot Update
	Supdate=y
	md5sum "${BASE_DIR}/Snapshot.txt" > "${BASE_DIR}/Snapshot.md5"
fi

# If there is an update for Released, then send HTTP requests
if [ "$Rupdate" == "y" ]; then
	echo "Sending notification for Released update...."
	curl -X POST "https://maker.ifttt.com/trigger/${applet}/with/key/${key}" --data "value1=New Update!&value2=${released}!"
else
	echo "No Update.. Doing nothing"
fi

# If there is an update for Snapshot, then send HTTP requests.
if [ "$Supdate" == "y" ]; then
        echo "Sending notification for Released update...."
        curl -X POST "https://maker.ifttt.com/trigger/${applet}/with/key/${key}" --data "value1=New Update!&value2=${snapshot}!"
else	echo "No Update.. Doing nothing"
fi

echo ${released}
echo ${snapshot}

