#!/bin/sh

# Composer
picom &

# Wallpaper
# feh --bg-tile ~/Images/Wallpapers/arch-fond11.jpg &
feh --bg-fill ~/Images/Wallpapers/arch-fond13.jpg &

# systray battery icon
cbatticon -u 5 &

# systray volume
volumeicon &

# Usb
udiskie -t &

# Network
nm-applet &
