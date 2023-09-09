#!/bin/sh

#Variables for the script
CMOS_PATH=$PWD
CMOS_DIR_EXTRAS=$CMOS_PATH/extras/
CMOS_DIR_SCRIPTS=$CMOS_PATH/src/scripts/


handler() {
    echo -e "\n\n[-] Script interrupted by user."
    exit 1
}
# This will run the handler function when a SIGINT is received
trap handler SIGINT


# Function that checks your internet connection
check_internet()
{

    if ! curl -s --connect-timeout 8 https://archlinux.org/ &> /dev/null; then

        echo -e "\n[-] You don't have an Internet connection !\n"
        exit 1
    
    fi

    return $SUCCESS
}


# Git config funciton
config_git() 
{
    chmod +x $CMOS_DIR_SCRIPTS/git/git.sh
    $CMOS_DIR_SCRIPTS/git/git.sh
}


# Xorg installation function
install_xorg() 
{
    echo -e "\n[!] Let's install XORG server for graphics !\n"
    sudo pacman -S xorg xorg-server xorg-xinit xorg-twm
    
    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Error installing XORG. Aborting...\n"
        exit 1
    
    fi
    
    echo -e "\n[+] X Server is installed successfully ! Continuing...\n"
}


# LightDM config and installation
install_lightdm() 
{
    echo -e "\n[!] LIGHTDM installation !\n"
    sudo pacman -S lightdm lightdm-webkit2-greeter

    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Error installing lightDM. Aborting...\n"
        exit 1
    
    fi

    sudo sed -i "s/#greeter-session=example-gtk-gnome/greeter-session=lightdm-webkit2-greeter/g" /etc/lightdm/lightdm.conf
    # LigthDM config
    sudo systemctl enable lightdm

    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Error enabling lightDM. Aborting...\n"
    
    fi

    echo -é "\n[-] Successfully installed lightDM !\n"
}



# __main__ script
echo -en "\n[?] Do you want to start the installation and CM-OS set up? [y/n] : "
read START_ANSWER

if [[ $START_ANSWER = [Yy] || -z $START_ANSWER ]]; then
    
    check_internet
    
    echo -e "\n[+] Starting installation...\n"
    sleep 1

    config_git

    install_xorg

    install_lightdm
    
    sleep 1


    ### DEKSTOPS installation

    desktops=("Qtile" "Bspwm" "Gnome" "KDE" "OpenBox" "Xmonad")

    echo -e "\n[*] Dektop and window managers avaliables !\n"
    
    for i in "${!desktops[@]}"; do
    
        echo -n "$((i+1))) ${desktops[i]}"
        echo -en "\t"

    done

    echo -en "\n\n[?] Enter a selection (default=all): " 
    read selection

    # If nothing is entered, default to installing all packages
    if [ -z "$selection" ]; then

        selection=$(seq -s, 1 ${#desktops[@]})
    
    fi

    # Convert comma-separated list of numbers to array
    IFS=',' read -ra selected_indices <<< "$selection"

    # Install selected or all packages
    for index in "${selected_indices[@]}"; do
        
        # Validate input
        if [[ $index -ge 1 && $index -le ${#desktops[@]} ]]; then
        
            package=${desktops[$((index-1))]}
            echo -e "\n[*] Installing $package...\n"
            sudo pacman -S $(echo "$package" | tr 'A-Z' 'a-z')
            echo -e "\n[+] $package installed successfully !\n"
        
        else

            echo -e "\n[-]Invalid option: $index\n"
        
        fi
    
    done


else

    echo -e "\n[-] Installation aborted.\n"
    exit 1

fi

# Author @napoknot21