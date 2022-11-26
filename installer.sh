#!/bin/sh

echo -n "Start installation ? [y/n] : "
read my_var

if [[ $my_var = [Yy] ]];then
	echo "Starting installation..."
	chmod +x ./src/scripts/user/user.sh
	chmod +x ./src/scripts/audio/audio.sh
else
	echo "Exiting of process"
fi


