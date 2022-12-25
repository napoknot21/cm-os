#!/bin/sh

if [ -z ${1+x} ]; then 
    echo -e "[*] The qtile script needs the username as argument...\n"
    echo -e "[*] Exiting...\n"
fi
# Qtile script

echo -e "[!] QTILE !\n"

# Package installation
echo -e "[*] Installing the package...\n"
sudo pacman -S qtile

# Config
echo -e "\n[*] Setting up the hackable twiling window manager...\n"

DIR_QTILE="'$1'/.config/qtile"

if [[ -n $DIR_QTILE  ]]; then
	rm -r $DIR_QTILE
else
	mkdir -p $DIR_QTILE
fi

mv ./src/* $DIR_QTILE


sleep 3
echo -e "[*] Config successfully copied !\n"
sleep 1
echo -e "[*] Moving on to the next step...\n"

# Author @napoknot21
