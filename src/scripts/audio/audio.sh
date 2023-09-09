#!/bin/sh

# Audio config
echo -e "\n[!] Audio config !\n"

# Installation
echo -e "\n[*] Installing base package and drivers...\n"
sudo pacman -S pulseaudio sof-firmware alsa-ucm-conf pavucontrol
# TODO : Check for other drivers in case of problems or any config file

# Success message
echo -e "\n[*] Services will work after rebootingyour device !\n"

echo -e "\n[+] Moving on to the next step...\n"

# Author @napoknot21
