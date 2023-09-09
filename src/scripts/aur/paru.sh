#!/bin/sh

#### Installer helper for the AUR repos ####

REPO_DIR="$HOME/.repos"
PARU_DIR="$REPO_DIR/paru"

# Check if the .repos directory exists
if [[ ! -d "$REPO_DIR" ]]; then

    echo "[*] Creating $REPO_DIR directory..."
    mkdir -p "$REPO_DIR"

fi

# Ensure we change directory to .repos
if cd "$REPO_DIR"; then

    # Check if paru directory already exists, if not, clone it
    if [ ! -d "$PARU_DIR" ]; then
    
        echo -e "\n[*] Cloning paru from AUR...\n"
        git clone https://aur.archlinux.org/paru.git
    
    else
    
        echo "[-] Paru directory already exists. If you want a fresh clone, delete the existing directory and rerun the script."
        exit 1
    
    fi

    # Change to paru directory and install
    if cd "paru"; then
    
        echo -e "\n[+] Installing the PARU helper...\n"
        makepkg -si
    
    else
    
        echo -e "\n[-] Failed to change directory to paru.\n"
        exit 1
    
    fi

else

    echo -e "\n[-] Failed to change directory to $REPO_DIR.\n"
    exit 1

fi
