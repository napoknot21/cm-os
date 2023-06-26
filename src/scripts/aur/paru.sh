#!/bin/sh

# Installer helper for the AUR repos

if [[ -f $HOME/.repos ]]; then
    cd $HOME/.repos
else
    mkdir $HOME/.repos && cd $HOME/.repos
fi

git clone https://aur.archlinux.org/paru.git

cd paru

echo -n "[*] Installing the PARU helper..."

makepkg -si
