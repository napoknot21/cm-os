#!/bin/sh

# Alacritty script
echo "[!] ALACRITTY !"

echo "[*] Installing the package..."
sudo pacman -S alacritty #starship

echo "[*] Setting up the emulator..."
mkdir ~/.config/alacritty/
mv ./scr/alacritty.yml ~/.config/alacritty
#mv ./scr/starship.toml ~/.config/

sleep 2
echo "[*] Alacritty succesfully set up !"
sleep 1
echo "[*] Moving on to the next step..."

# Author @napoknot21
