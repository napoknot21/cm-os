#!/bin/sh

#### Audio script installer ####

# Audio config
echo -e "\n[!] AUDIO config !\n"

# Try to install the packages
if ! sudo pacman -S pulseaudio sof-firmware alsa-ucm-conf pavucontrol; then

    echo -e "\n[-] Failed to install packages\n"
    exit 1
    
fi

sudo pacman -S alsa-oss

sudo modprobe snd-seq-oss snd-pcm-oss snd-mixer-oss

if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Error installing audio improves. Aborting...\n"
        exit 1
    
fi

# Success message
echo -e "\n[*] Services will work after rebooting your device !\n"

# Author @napoknot21