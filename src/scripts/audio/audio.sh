#!/bin/sh

#### Audio script installer ####

# Audio config
echo -e "\n[!] Audio config !\n"

# Installation
echo -e "\n[*] Installing base package and drivers...\n"

# Try to install the packages
if ! sudo pacman -S pulseaudio sof-firmware alsa-ucm-conf pavucontrol; then

    printf "[-] Failed to install packages. Check your network connection or package names.\n"
    
fi

# TODO : Check for other drivers in case of problems or any config file

# Success message
echo -e "\n[*] Services will work after rebootingyour device !\n"
echo -e "\n[+] Moving on to the next step...\n"

# Author @napoknot21