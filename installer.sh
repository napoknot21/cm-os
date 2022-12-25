#!/bin/sh

echo -n "[?] Do you want to start the installation and set up? [y/n] : "
read my_var

if [[ $my_var = [Yy] ]];then
    echo "[*] Starting installation...\n"
    sleep 1
    
    
    # Local time and clock
    echo "[*] Setting the local clock..."
    ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
    hwclock --systohc
    sleep 1
    # TODO local-gen 
    echo -e "[!] Done ! \n"


    # Keymap and language config
    echo "LANG=us_US.UTF-8" > /etc/locale.conf
    echo "KEYMAP=fr" > /etc/vconsole.conf
    echo "[?] Your Hostname (device's name): "
    read hostname_device
    echo $hostname_device > /etc/hostname
    echo "[!] Done ! \n"
    
    # Network localhost
    echo -e "\n" >> /etc/hosts
    echo -e "127.0.0.1\tlocalhost" >> /etc/hosts
    echo -e "::1\tlocalhost" >> /etc/hosts
    echo -e "127.0.1.1\t$hostname_device.localhost\t$hostname_device" >> /etc/hosts
    echo -e "[!] Done !\n" 

    #installation of basic packages
    pacman -S networkmanager network-manager-applet bluez bluez-utils pulseaudio pulseaudio-bluetooth alsa-utils dosfstools mtools cups

    # Start/Enbale basic services
    systemctl enable NetworkManager
    systemctl enable bluetooth
    systemctl enable cups.service

    
    # Permission for other scripts
    # chmod +x ./src/scripts/user/user.sh
    # chmod +x ./src/scripts/audio/audio.sh
    # chmod +x ./src/scripts/black-arch/black-arch.sh
    # TODO change permission for other scripts...    
    
    
    # Setting up the user
    echo -e "\n[*] Setting up your username... !\n"
    echo "[?] Your username : "
    read home_user
    useradd -m $home_user
    echo "\n[*] Enter 2 times your password !"
    passwd $home_user
    usermod -aG wheel,storage,video,audio,optical $home_user
    
    
    

else
	echo "[*] Exiting...!"
fi


