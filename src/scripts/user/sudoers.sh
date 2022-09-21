#!/bin/sh

echo "[*] Modifying the /etc/sudoers file..."
pacman -S sudo
$line=(cat /etc/sudoers | grep -n "wheel ALL=(ALL:ALL) ALL" | awk -F ":" '{print $1}')

# Uncomment the '$line' line
# TODO Synthaxe for the sed (and flags) command one liner
# sed -i \'\$(echo $line)s/.*/replacement-line/' /etc/sudoers

# Author @napoknot21
