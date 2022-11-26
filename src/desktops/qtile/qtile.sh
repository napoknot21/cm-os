#!/bin/sh

# Qtile script

echo -e "[!] QTILE !\n"

# Package installation
echo -e "[*] Installing the package...\n"
sudo pacman -S qtile

# Config
echo -e "\n[*] Setting up the hackable twiling window manager...\n"

DIR_QTILE="~/.config/qtile"

if [[ -n $DIR_QRTILE  ]]; then
	rm -r $DIR_QTILE
else
	mkdir -p $DIR_QTILE
fi

mv ./src/* ~/.config/qtile/


sleep 3
echo -e "[*] Config successfully copied !\n"
sleep 1
echo -e "[*] Moving on to the next step...\n"

# Author @napoknot21
