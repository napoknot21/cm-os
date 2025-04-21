#!/bin/sh

#### Qtile config script #####

echo -e "\n[!] QTILE !\n"

# Package installation
echo -e "[*] Installing the package...\n"

sudo pacman -S qtile

# Config
echo -e "\n[*] Setting up the hackable tiling window manager...\n"

# Path directory
QTILE_DIR=$1

# Check if directory exists, if it does, delete, otherwise create
mkdir -p $HOME/.config/qtile

# Copying files
if ! cp -rv $QTILE_DIR/src_2/* $HOME/.config/qtile; then

    echo -e "\n[-] Failed to copy config files. Aborting...\n"
    exit 1

fi

# Success message
echo -e "\n[*] Config successfully copied !\n"

# Author @napoknot21
