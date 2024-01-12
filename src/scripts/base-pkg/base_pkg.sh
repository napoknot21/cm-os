#!/bin/sh

# Base packages for the ArchLinux system

# For images and 
sudo pacman -S feh picom

# Icons and widgets
sudo pacman -S volumeicon udiskie cbatticon libnotify notification-daemon

sudo echo -e "[D-BUS Service]\nName=org.freedesktop.Notifications\nExec=/usr/lib/notification-daemon-1.0/notification-daemon" > /usr/share/dbus-1/services/org.freedesktop.Notifications.service

# Test for notifications
notify-send 'If you see that, the notifications are perfect'

# Base packages
sudo pacman -S zip unzip mdcat ntfs-3g brightnessctl scrot redshift code vlc locate htop rofi papirus-icon-theme bat lsd exa ranger bat-extras slock openvpn

paru -S i3lock-fancy 

# Setting up Nvim theme
