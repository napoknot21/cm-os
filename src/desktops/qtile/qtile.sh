#!/bin/sh

#### Qtile config script #####

DIR_QTILE="$HOME/.config/qtile"

echo -e "\n[!] QTILE !\n"

# Package installation
echo -e "[*] Installing the package...\n"

if ! sudo pacman -S qtile; then
    echo -e "\n[-] Failed to install Qtile. Aborting...\n"
    exit 1
fi

# Config
echo -e "\n[*] Setting up the hackable tiling window manager...\n"

# Check if directory exists, if it does, delete, otherwise create
if [ -d "$DIR_QTILE" ]; then

    rm -r "$DIR_QTILE"

fi

mkdir -p "$DIR_QTILE"

# Copying files
if ! cp -r ./src/* "$DIR_QTILE"; then
    echo -e "\n[-] Failed to copy config files. Aborting...\n"
    exit 1
fi


echo -e "\n[*] Config successfully copied !\n"
sleep 1
echo -e "[*] Moving on to the next step...\n"

# Author @napoknot21