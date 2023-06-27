#!/bin/bash
users=( ap0calypseplease apocalypseplease0 ) #Put in usernames that should be checked here
while true
do
	for i in "${users[@]}"
	do
		status=`twitch-stream-check $i`
		if echo "$status" | grep "is streaming" | awk '{print $1;}'; then
			test	
		else
			echo ""
		fi
	done
	sleep 15
done
