#!/bin/sh

#### Audio script installer ####

# Audio config
echo -e "\n[!] AUDIO config !\n"

# Try to install the packages
# In case that you want to install pulseaudio, then install this instead
# sudo pacman -S pulseaudio pavucontrol sof-firmware alsa-ucm-conf
if ! sudo pacman -S pipewire sof-firmware alsa-ucm-conf ; then

    echo -e "\n[-] Failed to install packages\n"
    exit 1
    
fi

# Success message
echo -e "\n[*] Services will work after rebooting your device !\n"

# Author @napoknot21
