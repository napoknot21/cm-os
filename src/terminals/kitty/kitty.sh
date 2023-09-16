#!/bin/sh

#### Kitty config script ####

echo -e "\n[!] KITTY !\n"

# Package installation
echo -e "\n[*] Installing the package...\n"

sudo pacman -S kitty

#Kitty dir
KITTY_DIR=$1

# Config
echo -e "\n[*] Setting up the Kitty terminal emulator...\n"

# Check if directory exists, if it does, delete, otherwise create
mkdir -p $HOME/.config/kitty

# Copy the config files
if ! cp -rv $KITTY_DIR/src/color.ini ./src/kitty.conf $HOME/.config/kitty/; then

    echo -e "\n[-] Failed to copy kitty configuration. Aborting...\n"
    exit 1

fi

# Copy the prompt config
if ! cp -rv $KITTY_DIR/src/.p10k.zsh $HOME/; then

    echo -e "\n[-] Failed to copy kitty p10k configuration. Aborting...\n"
    echo 1

fi

# Success message
echo -e "\n[+] Kitty succesfully set up !\n"

# Author @napoknot21