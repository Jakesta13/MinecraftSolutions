#!/bin/bash

### ### ### Settings ### ### ###

# This script is a detector for dupe books, this should be fairly accurate.
# I tested this and it will even trigger if the player has only one book, at default settings.
# From my findings, one book will raise the player's data file to just above 20kb, more books will
# increase the data file further.
## I have opted out to run an auto /ban command on the server as this is just to make it moderately easier to
## investigate, as the books have to be signed you can then check the NBT data of the player to find the source.

BASE_DIR=.
# Size to check above
# in KB
size=20

# directory to playerdata files in active world
dir=.


# FTP server settings
user=
pass=
ip=


#IFTTT settings
# Key
key=
# Applet
app=

# https://github.com/jakesta13
### ### ### ### ### ###

# Checking if files exist that we need.
# If they do not exist already, we will make them.

if [ ! -e "${BASE_DIR}/Reported.txt" ]; then
	touch "${BASE_DIR}/Reported.txt"
fi
if [ ! -e "${BASE_DIR}/ToReport.txt" ]; then
	touch "${BASE_DIR}/ToReport.txt"
fi
if [ ! -e "${BASE_DIR}/temp.txt" ]; then
	touch "${BASE_DIR}/temp.txt"
fi
temp=${BASE_DIR}/temp.txt

# Finding  UUID player-data files that are more than specified kiliobytes.
# We will then dump our findings in a temp file while we sort it later.
cd "${dir}" && find . -type f -size +${size}k | sed 's=./==' | sed 's/.dat//' > "${temp}"


# Sorting the UUID list so we can delete lines that match each other
# with the already reported list, to avoid alerting more that once.
sortRe=$(cat "${BASE_DIR}/Reported.txt" | sort -u)
sortTemp=$(cat ${temp} | sort -u)
echo ${sortRe} | tr ' ' '\n' > "${BASE_DIR}/Reported.txt" 
echo ${sortTemp} | tr ' ' '\n' > ${temp}

# Unfortunately I lost the source of where I found this command example.
comm -23 ${temp} ${BASE_DIR}/Reported.txt > ${BASE_DIR}/ToReport.txt

# Clearing the temporary file, to avoid confusion as we don't need it anymore.
echo "" > ${temp}

# Check if report file is empty
empty=$(wc -c < "${BASE_DIR}/ToReport.txt")
if [ "${empty}" == "0" ] ; then
	echo "Nothing to report"
else
	echo do this
# preparing variable for HTTP request (multi-line to single line, with separation)
	list=$(cat ${BASE_DIR}/ToReport.txt | tr '\n' ',' | sed 's/,/, /')
	curl -X POST "https://maker.ifttt.com/trigger/${app}/with/key/${key}" --data "value1=${list}."

# Uploading suspected user data files to speciied FTP server for reviewing
	cat ${BASE_DIR}/ToReport.txt | xargs -I [] lftp -c "open -u ${user},${pass} ${ip}; put ${dir}/[].dat"

# Uploading a text file with users reported, filename will include date and time
	date=$(date | tr ':' '-' | tr ' ' '_')
	touch ${BASE_DIR}/ToReport_${date}.txt
	cp ${BASE_DIR}/ToReport.txt ${BASE_DIR}/ToReport_${date}.txt
	lftp -c "open -u ${user},${pass} ${ip}; put ${BASE_DIR}/ToReport_${date}.txt"
# Adding the users that were just reported into a file that we will check next time,
# if the same user appears again, we will ignore in order to avoid multiple reports of the same event.
	cat "${BASE_DIR}/ToReport.txt" >> "${BASE_DIR}/Reported.txt"
	sort -u "${BASE_DIR}/Reported.txt" > "${temp}"

# Cleanup.
	mv ${temp} ${BASE_DIR}/Reported.txt
	rm ${BASE_DIR}/ToReport_${date}.txt
fi
exit
