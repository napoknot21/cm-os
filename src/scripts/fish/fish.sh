#!/bin/sh

# Fish config

echo "[!] FISH !"

# Package installation
echo "[*] Installing the package..."
sudo pacman -S fish starship

# Config
echo "[*] Setting up the interactive shell..."
rm ~/.config/fish/config.fish
mv ./src/config.fish ~/.config/fish/
mv ./src/starship.toml ~/.config/

# Success message
sleep 2
echo "[*] Fish succesfully set up !"
sleep 1
echo "[*] Moving on to the next step..."

# Author @napoknot21
