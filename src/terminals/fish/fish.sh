#!/bin/sh

#### Fish config ####

echo -e "\n[!] FISH !\n"

# Package installation
echo -e "\n[*] Installing the package...\n"
sudo pacman -S fish starship

# Config
echo -e "\n[*] Setting up the interactive shell...\n"

# Fish dir
FISH_DIR=$1

# Ensure the directory exists or create it
mkdir -p $HOME/.config/fish/

# Remove the file if it exists
rm -f $HOME/.config/fish/config.fish

# Copy the config files
if ! cp -v $FISH_DIR/src/config.fish $HOME/.config/fish/; then

    echo -e "\n[-] Failed to copy config.fish. Aborting...\n"
    exit 1
fi

if ! cp -v $FISH_DIR/src/starship.toml $HOME/.config/; then

    echo -e "\n[-] Failed to copy starship.toml. Aborting...\n"
    exit 1

fi

# Change shell
chsh -s /bin/fish

# Success message
echo -e "\n[+] Fish succesfully installed and set up !\n"

# Author @napoknot21