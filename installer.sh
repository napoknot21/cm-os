#!/bin/sh

echo -n "Start installation ? [y/n] : "
read my_var

if [ my_var = "y" ];
then 
echo "Starting installation..."
else
echo "Exiting of process"
fi
