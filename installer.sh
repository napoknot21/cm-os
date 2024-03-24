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



# Audio installation and config
install_audio()
{
    chmod +x $CMOS_DIR_SCRIPTS/audio/audio.sh
    $CMOS_DIR_SCRIPTS/audio/audio.sh
}



# Shell Installation (Fish and Zsh)
install_shell() 
{
    echo -e "\n[!] Let's install FISH and ZSH shells\n"

    chmod +x $CMOS_DIR_TERMINALS/fish/fish.sh
    $CMOS_DIR_TERMINALS/fish/fish.sh $CMOS_DIR_TERMINALS/fish

    chmod +x $CMOS_DIR_TERMINALS/zsh/zsh.sh
    $CMOS_DIR_TERMINALS/zsh/zsh.sh $CMOS_DIR_TERMINALS/zsh

    echo -e "\n[+] Shells are installed successfully !\n"
}



# Terminal installation (Alacritty and Kitty)
install_terminal() 
{
    echo -e "\n[!] Let's install ALACRITTY and KITTY terminals !\n"
    

    chmod +x $CMOS_DIR_TERMINALS/alacritty/alacritty.sh
    $CMOS_DIR_TERMINALS/alacritty/alacritty.sh $CMOS_DIR_TERMINALS/alacritty

    chmod +x $CMOS_DIR_TERMINALS/kitty/kitty.sh
    $CMOS_DIR_TERMINALS/kitty/kitty.sh $CMOS_DIR_TERMINALS/kitty

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
                $CMOS_PATH/src/desktops/qtile/qtile.sh $CMOS_PATH/src/desktops/qtile
            
            elif [ "$package" == "Bspwm" ]; then

                chmod +x $CMOS_PATH/src/desktops/bspwm/bspwm.sh
                $CMOS_PATH/src/desktops/bspwm/bspwm.sh $CMOS_PATH/src/desktops/bspwm
                chmod +x $CMOS_DIR_SCRIPTS/polybar/polybar.sh
                $CMOS_DIR_SCRIPTS/polybar/polybar.sh $CMOS_DIR_SCRIPTS/polybar
            
            elif [ "$package" == "Xmonad" ]; then

                chmod +x $CMOS_PATH/src/desktops/xmonad/xmonad.sh
                $CMOS_PATH/src/desktops/xmonad/xmonad.sh $CMOS_PATH/src/desktops/xmonad
                  
            elif [ "$package" == "OpenBox" ]; then
            
                chmod +x $CMOS_PATH/src/desktops/openbox/openbox.sh
                $CMOS_PATH/src/desktops/openbox/openbox.sh $CMOS_PATH/src/desktops/openbox
            
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

    echo -e "\n[+] Successfully installed lightDM !\n"
}



# Rofi installation and config
install_rofi() 
{
    echo -e "\n[!] ROFI installation !\n"

    # Install rofi and the icon theme
    sudo pacman -S rofi papirus-icon-theme
    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Failed to install rofi and papirus-icon-theme.\n"
        exit 1
    
    fi

    # Create or ensure the rofi config directory exists
    mkdir -p $HOME/.config/rofi
    if [ $? -ne 0 ]; then

        echo -e "\n[-] Failed to create the rofi directory.\n"
        exit 1
    
    fi

    # Copy the rofi config file
    if ! cp -rv $CMOS_DIR_SCRIPTS/rofi/src/* $HOME/.config/rofi; then
    
        echo -e "\n[-] Failed to copy the rofi config.\n"
        exit 1
    
    fi        
}



# Install fonts
install_fonts() 
{
    echo -e "\n[!] FONTS installation !\n"

    chmod +x $CMOS_PATH/src/fonts/fonts.sh
    $CMOS_PATH/src/fonts/fonts.sh

    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Failed to install fonts\n"
        exit 1
    
    fi

    echo -e "\n[+] Fonts are installed !\n"
}



# Paru config
install_paru()
{
    echo -e "\n[!] PARU installation !\n"
    # Create or ensure .repos directory exists
    mkdir -p $HOME/.repos

    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Failed to create .repos directory.\n"
        exit 1
    
    fi

    # Change to .repos directory
    cd $HOME/.repos
    
    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Failed to change to .repos directory.\n"
        exit 1
    
    fi

    # Clone paru repository if it doesn't exist
    if [ ! -d "$HOME/.repos/paru" ]; then
        
        git clone https://aur.archlinux.org/paru.git
        
        if [ $? -ne 0 ]; then
            
            echo -e "\n[-] Failed to clone paru repository\n"
            exit 1
        
        fi

    fi

    # Change to paru directory and install
    cd $HOME/.repos/paru

    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Failed to change to paru directory.\n"
        echo 1
    
    fi

    makepkg -si
    
    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Failed to install paru\n"
        exit 1
    
    fi
}



# Programming languages installation
install_lang()
{
    echo -e "\n[!] PROGRAMMING LANGUAGES installation\n"

    chmod +x $CMOS_PATH/src/prg-lan/prg-lan.sh
    $CMOS_PATH/src/prg-lan/prg-lan.sh

    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Failed install the programming languages...\n"
        exit 1
    
    fi

    echo -e "\n[+] Python, Java, C, etc... Set up correctly !\n"
}



# Base packages installation
install_base()
{
    echo -e "\n[!] BASE PACKAGES installation\n"

    chmod +x $CMOS_DIR_SCRIPTS/base-pkg/base_pkg.sh
    $CMOS_DIR_SCRIPTS/base-pkg/base_pkg.sh

    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Failed install the base packages for the environment...\n"
        exit 1
    
    fi

    echo -e "\n[+] Packages installed successfully !\n"
}



# Base Picom file config 
install_picom()
{
    echo -e "\n[!] PICOM SETUP !\n"

    # Create or ensure the picom config directory exists
    mkdir -p $HOME/.config/picom
    if [ $? -ne 0 ]; then

        echo -e "\n[-] Failed to create the picom directory.\n"
        exit 1
    
    fi

    # Copy the rofi config file
    if ! cp -rv $CMOS_DIR_SCRIPTS/picom/src/* $HOME/.config/picom; then
    
        echo -e "\n[-] Failed to copy the rofi config.\n"
        exit 1
    
    fi

    echo -e "\n[+] Picom set up successfully !\n"
}



# Black arch packages installation
install_blackarch()
{
    chmod +x $CMOS_DIR_SCRIPTS/black-arch/black-arch.sh
    $CMOS_DIR_SCRIPTS/black-arch/black-arch.sh

    sudo pacman -Syyyu

    if [ $? -ne 0 ]; then

        echo -e "\n[-] Impossible synchronize the database\n"
        exit 1

    fi

    echo -e "\n[+] Black arch successfully synchronised !\n"
}



# Browser installation (Brave)
install_browser()
{
    echo -e "\n[!] BRAVE installation !\n"

    paru -S brave-bin

    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Failed to install Brave\n"
        exit 1
    
    fi

    echo -e "\n[+] Brave is installed successfully !\n"
}



# Theme installation and config
install_themes()
{
    echo -e "\n[!] THEME Material Black Blueberry !\n"

    #icons=$(unzip $CMOS_PATH/extras/themes/Material-Black-Blueberry-Suru_1.9.3.zip)
    #theme=$(unzip $CMOS_PATH/extras/themes/Material-Black-Blueberry-2.9.9-05.zip)

    #sudo mv $icons /usr/share/icons
    #sudo mv $theme /usr/share/themes

    #if [ $? -ne 0 ]; then
    
    #    echo -e "\n[-] Failed to config the theme and the icons...\n"
        #exit 1
    
    #fi

    if ! cp -v $CMOS_DIR_EXTRAS/.gtkrc-2.0 $HOME; then
    
        echo -e "\n[-] Failed to copy the .gtkrc-2.0 config.\n"
        exit 1
    
    fi

    mkdir -p $HOME/.config/gtk-3.0

    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Failed to install Brave\n"
        exit 1
    
    fi

    if ! cp -v $CMOS_DIR_EXTRAS/settings.ini $HOME/.config/gtk-3.0; then
    
        echo -e "\n[-] Failed to copy the rofi config.\n"
        exit 1
    
    fi

    echo -e "\n[+] theme and icons are installed successfully !\n"
}



# Xprofile configuration settings
final_config ()
{
    echo -e "\n[-] Xprofile settings ! \n"

    cp $CMOS_PATH/extras/.xprofile $HOME

    if [ $? -ne 0 ]; then
    
        echo -e "\n[-] Failed to set up the final config...\n"
        exit 1
    
    fi

    echo -e "\n[+] BFinal config set up successfully !\n"
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
    
    install_audio

    sleep 1

    install_shell

    install_terminal

    install_desktop

    install_lightdm
    
    install_rofi
    
    sleep 1

    install_fonts
    
    install_paru

    install_lang

    install_base

    install_picom

    install_blackarch

    install_browser

    install_themes

    final_config

else

    echo -e "\n[-] Installation aborted.\n"
    exit 1

fi

# Author @napoknot21