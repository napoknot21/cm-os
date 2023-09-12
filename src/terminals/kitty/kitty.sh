#!/bin/sh

#### Kitty config script ####

DIR_KITTY="$HOME/.config/kitty"

echo -e "\n[!] KITTY !\n"

# Package installation
echo -e "\n[*] Installing the package...\n"

sudo pacman -S kitty

# Config
echo -e "\n[*] Setting up the emulator...\n"

# Check if directory exists, if it does, delete, otherwise create
if [ -d "$DIR_KITTY" ]; then

    rm -r "$DIR_KITTY"

fi

# Create the directory (and all parents as needed) if it doesn't exist
mkdir -p $HOME/.config/kitty

# Copy the config files
if ! cp -rv ./src/* $HOME/.config/kitty/; then

    echo -e "\n[-] Failed to copy Alacritty configuration. Aborting...\n"
    exit 1

fi

# Success message
echo -e "\n[+] Kitty succesfully set up !\n"

# Author @napoknot21