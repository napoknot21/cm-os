#!/bin/sh

#### Zsh config ####

echo -e "\n[!] ZSH !\n"

# Package installation
echo -e "\n[*] Installing the package...\n"
sudo pacman -S zsh zsh-autosuggestions zsh-syntax-highlighting zsh-completions

# Config
echo -e "\n[*] Setting up the fastest shell...\n"

# Zsh dir
ZSH_DIR=$1

# Copy the config files
if ! cp -v $ZSH_DIR/src/.zshrc $HOME/; then

    echo -e "\n[-] Failed to copy zshrc. Aborting...\n"
    exit 1
fi

if ! cp -v $ZSH_DIR/src/.p10k.zsh $HOME/; then

    echo -e "\n[-] Failed to copy p10k config. Aborting...\n"
    exit 1 
fi

# Success message
echo -e "\n[+] Zsh succesfully installed and set up !\n"

# Author @napoknot21
