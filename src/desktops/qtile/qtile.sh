#!/bin/sh

# Qtile script

echo "[!] QTILE !"

# Package installation
echo "[*] Installing the package..."
sudo pacman -S qtile

# Config
echo "[*] Setting up the hackable tiling window manager..."
rm -r ~/.config/qtile
mv ./src/* ~/.config/qtile/

sleep 3
echo "[*] Config successfully copied !"
sleep 1
echo "[*] Moving on to the next step..."

# Author @napoknot21
