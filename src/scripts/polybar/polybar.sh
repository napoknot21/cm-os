#!/bin/sh

#### Polybar config ####

echo -e "\n[!] Polybar !\n"

# Package installation
echo -e "\n[*] Installing the package...\n"
sudo pacman -S polybar

# Polybar dir
POLYBAR_DIR=$1

# Ensure the directory exists or create it
mkdir -p $HOME/.config/polybar

# Copy of the fonts
if ! sudo cp $POLYBAR_DIR/src/fonts/* /usr/share/fonts/; then
    
    echo -e "\n[-] Failed to copy files to Polybar. Aborting...\n"
    exit 1

fi

# Copy the config files
if ! cp -vr $POLYBAR_DIR/src/* $HOME/.config/polybar/; then

    echo -e "\n[-] Failed to copy files to Polybar. Aborting...\n"
    exit 1

fi

# Success message
echo -e "\n[+] Polybar succesfully installed and set up !\n"

# Author @napoknot21