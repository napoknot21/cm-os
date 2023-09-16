#!/bin/sh

#### BDPWM config script ####

echo -e "\n[!] BSPWM !\n"

# Package installation
echo -e "\n[*] Installing the package...\n"

sudo pacman -S bspwm sxhkd

# Config
echo -e "\n[*] Setting up the customized tiling window manager...\n"

# Path directory
BSPWM_DIR=$1

# Check if directory exists, if it does, delete, otherwise create
mkdir -p $HOME/.config/bspwm && mkdir -p $HOME/.config/sxhkd

# Copying files
if ! cp -rv $QBSPWM_DIR/src/bspwmrc $QBSPWM_DIR/src/scripts $HOME/.config/bspwm; then

    echo -e "\n[-] Failed to copy config files. Aborting...\n"
    exit 1

fi

if ! cp -rv $QBSPWM_DIR/src/sxhkdrc $HOME/.config/sxhkd; then

    echo -e "\n[-] Failed to copy config files. Aborting...\n"
    exit 1

fi

# Success message
echo -e "\n[*] Config successfully copied !\n"

# Author @napoknot21