#!/bin/sh

echo -en "\n[?] Do you want to start the installation and set up? [y/n] : "
read START_ANSWER

handler()
{
    kill -s SIGINT $PID
}


check_internet()
{
    tool='curl'
    tool_opts='-s --connect-timeout 8'

    if ! $tool $tool_opts https://archlinux.org/ > /dev/null 2>&1; then
    
        echo -e "\n[-] You don't have an Internet connection !\n"
        exit 1
    
    fi

    return $SUCCESS
}


#Script
if [[ $START_ANSWER = [Yy] || -z $START_ANSWER ]]; then
    
    #handler()
    check_internet
    
    #Variables for the script
    CMOS_PATH=$PWD
    CMOS_DIR_EXTRAS=$CMOS_PATH/extras/
    CMOS_DIR_SCRIPTS=$CMOS_PATH/src/scripts/

    echo -e "\n[+] Starting installation...\n"
    
    
    sleep 1


    # REQUIRED PACKAGES AND CONFIG
    
    ### GIT check
    
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

        echo -e "\n[*] .gitconfig has been created with the provided name and email."

    else
    
        echo "\n[+] .gitconfig already exists. Continuing...\n"
    
    fi


    sleep 1


    ### XORG installation

    echo -e "\n[*] Let's install XORG server for graphics !\n"

    sudo pacman -S xorg xorg-server xorg-xinit

    echo -e "\n[+] X Server is installed successfully ! continuing...\n"


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
            echo -e "\n[*] Installing $package..."
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
