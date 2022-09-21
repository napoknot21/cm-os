#!/bin/sh

# Audio config
echo "[!] Audio config !"

# Installation
echo "[*] Installing base package and drivers..."
sudo pacman -S pulseaudio sof-firmware alsa-ucm-conf pavucontrol
# TODO : Check for other drivers in case of problems or any config file

# Success message
echo "[*] Services will work after rebootingyour device !"

echo "[*] Moving on to the next step..."

# Author @napoknot21
