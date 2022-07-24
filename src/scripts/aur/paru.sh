#!/bin/sh

# Installer helper for the AUR repos

cd ~/.repos
git clone https://aur.archlinux.org/paru.git
cd paru-bin
echo -n "Installing the PARU helper"
makepkg -si
