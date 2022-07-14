#!/bin/sh

echo -n "Enter a name to create a your user : "
read user_name

useradd -m $user_name

echo -n "Enter your password"

passwd $user_name

echo -n "Adding your user to groups..."

usermod -aG wheel,storage,optical,audio,video $user_name

echo -n "User succesfully added to your system !"
