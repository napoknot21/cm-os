#!/bin/sh

#### Alacritty script #### 

echo -e "\n[!] ALACRITTY !\n"

# Package installation
echo -e "\n[*] Installing the package...\n"

sudo pacman -S alacritty

# Config
echo -e "\n[*] Setting up the fastest emulator...\n"

# Check if the directory exists before trying to create it
# Create the directory (and all parents as needed) if it doesn't exist
if ! mkdir -p $HOME/.config/alacritty; then

    echo -e "\n[-] Failed to create alacritty configuration directory. Aborting...\n"
    exit 1

fi

# Copy the config files
if ! cp -rv ./src/* $HOME/.config/alacritty/; then

    echo -e "\n[-] Failed to copy Alacritty configuration. Aborting...\n"
    exit 1

fi


# Success message
echo -e "\n[+] Alacritty succesfully set up !\n"

# Author @napoknot21