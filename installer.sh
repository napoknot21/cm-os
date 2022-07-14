#!/bin/sh

echo -n "Start installation ? [y/n] : "
read my_var

if [[ $my_var = [Yy] ]];
then 
echo "Starting installation..."
chmod 777 ./src/scripts/user/user.sh
else
echo "Exiting of process"
fi
