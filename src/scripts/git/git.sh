#!/bin/sh

#### Config script for git ####

# Check if git is available
if [[ ! $(command -v git) ]]; then

    echo -e "\n[-] Git is not installed !\n"
    
    sleep 1
    
    echo -e "\n\n[*] Installing git !\n\n"
    sudo pacman -S git

fi

# Git config file
GITCONFIG_FILE=$HOME/.gitconfig

if [[ ! -f "$GITCONFIG_FILE" ]]; then

    echo -e "\n[!] .gitconfig does not exist. Creating one now..."

    # Ask for the user's name and email
    echo -en "\n[?] Enter your name: " 
    read name_git
    echo -en "[?] Enter your email: "
    read email_git

    # Create the .gitconfig file and add name and email
    git config --global user.name "$name_git"
    git config --global user.email "$email_git"

    echo -e "\n[+] .gitconfig has been created with the provided name and email."

else

    echo -e "\n[+] .gitconfig already exists. Continuing...\n"

fi

# Author @napoknot21