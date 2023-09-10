#!/bin/sh

#Variables for the script
CMOS_PATH=$PWD
CMOS_DIR_EXTRAS=$CMOS_PATH/extras/
CMOS_DIR_SCRIPTS=$CMOS_PATH/src/scripts/
CMOS_DIR_TERMINALS=$CMOS_PATH/src/terminals/


handler() 
{
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


# Shell Installation (Fish and Zsh)
install_shell() 
{
    echo -e "\n[!] Let's install FISH and ZSH shells\n"

    chmod +x $CMOS_DIR_TERMINALS/fish/fish.sh
    $CMOS_DIR_TERMINALS/fish/fish.sh

    chmod +x $CMOS_DIR_TERMINALS/zsh/zsh.sh
    $CMOS_DIR_TERMINALS/zsh/zsh.sh

    echo -e "\n[+] Shells are installed successfully !\n"
}


# Terminal installation (Alacritty and Kitty)
install_terminal() 
{
    echo -e "\n[!] Let's install ALACRITTY and KITTY terminals !\n"
    

    chmod +x $CMOS_DIR_TERMINALS/alacritty/alacritty.sh
    $CMOS_DIR_TERMINALS/alacritty/alacritty.sh

    chmod +x $CMOS_DIR_TERMINALS/kitty/kitty.sh
    $CMOS_DIR_TERMINALS/kitty/kitty.sh

    if [ $? -ne 0 ]; then

        echo -e "\n[-] Error installing ALACRITTY and KITTY. Aborting...\n"
        exit 1

    fi

    echo -e "\n[+] Terminals set up and installed successfully !\n"
}


# Desktop installation
install_desktop() 
{
    desktops=("Qtile" "Bspwm" "OpenBox" "Xmonad")
    
    echo -e "\n[!] DEKSTOP and WM installation !\n"
    
    for i in "${!desktops[@]}"; do
    
        echo -n "$((i+1))) ${desktops[i]}"
        echo -en "\t"
    
    done
    
    echo -en "\n\n[?] Enter a selection (default=all): " 
    read selection
    
    if [ -z "$selection" ]; then
    
        selection=$(seq -s, 1 ${#desktops[@]})
    
    fi
    
    IFS=',' read -ra selected_indices <<< "$selection"
    
    # Install selected or all packages
    for index in "${selected_indices[@]}"; do
        
        # Validate input
        if [[ $index -ge 1 && $index -le ${#desktops[@]} ]]; then
        
            package=${desktops[$((index-1))]}
            echo -e "\n[*] Installing $package...\n"

            # Run respective script based on selected package
            if [ "$package" == "Qtile" ]; then

                chmod +x $CMOS_PATH/src/desktops/qtile/qtile.sh
                $CMOS_PATH/src/desktops/qtile/qtile.sh
            
            elif [ "$package" == "Bspwm" ]; then

                chmod +x $CMOS_PATH/src/desktops/bspwm/bspwm.sh
                $CMOS_PATH/src/desktops/bspwm/bspwm.sh
            
            elif [ "$package" == "Xmonad" ]; then

                chmod +x $CMOS_PATH/src/desktops/xmonad/xmonad.sh
                $CMOS_PATH/src/desktops/xmonad/xmonad.sh
                  
            elif [ "$package" == "OpenBox" ]; then
            
                chmod +x $CMOS_PATH/src/desktops/openbox/openbox.sh
                $CMOS_PATH/src/desktops/openbox/openbox.sh
            
            else

                echo -e "\n[-] Script for $package not found. Skipping...\n"
            
            fi
                   
        else

            echo -e "\n[-]Invalid option: $index\n"
        
        fi
    
    done
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



# Main script
echo -en "\n[?] Do you want to start the installation and CM-OS set up? [y/n] : "
read START_ANSWER

if [[ $START_ANSWER = [Yy] || -z $START_ANSWER ]]; then
    
    check_internet
    
    echo -e "\n[+] Starting installation...\n"
    sleep 1

    config_git

    install_xorg

    install_shell

    install_terminal

    install_desktop

    install_lightdm

    sleep 1

else

    echo -e "\n[-] Installation aborted.\n"
    exit 1

fi

# Author @napoknot21