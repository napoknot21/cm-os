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
if [[ $START_ANSWER = [Yy] ]]; then
    
    #handler
    check_internet

    echo "[+] Starting installation...\n"
    sleep 1

    #Variables for the script
    CMOS_PATH=$PWD
    CMOS_DIR_EXTRAS=$CMOS_PATH/extras/
    CMOS_DIR_SCRIPTS=$CMOS_PATH/src/scripts/

    # REQUIRED PACKAGES AND CONFIG
    
    ### GIT check
    
    GITCONFIG_FILE=$HOME/.gitconfig
    
    if [[ ! -f "$GITCONFIG_FILE" ]]; then

        echo -e "\n[!] .gitconfig does not exist. Creating one now..."

        # Ask for the user's name and email
        echo -e "\n[?] Enter your name: " 
        read name_git
        echo -e "[?] Enter your email: "
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

    echo -e "\n[*] X Server is installed successfully ! continuing...\n"


    sleep 1


    ### DEKSTOPS installation

    dektops=("Qtile" "Bspwm" "Gnome" "KDE" "OpenBox" "Xmonad")

    echo -e "\n[*] Dektop and window managers avaliables !\n"
    
    for i in "${!options[@]}"; do
    
        echo -e "\n[]"
        echo "$((i+1))) ${options[i]}"
        echo -e "\n"

    done

    echo -e "\n[?] Enter a selection (default=all): " 
    read selection

    # If nothing is entered, default to installing all packages
    if [ -z "$selection" ]; then

        selection=$(seq -s, 1 ${#options[@]})
    
    fi

    # Convert comma-separated list of numbers to array
    IFS=',' read -ra selected_indices <<< "$selection"

    # Install selected or all packages
    for index in "${selected_indices[@]}"; do
        
        # Validate input
        if [[ $index -ge 1 && $index -le ${#options[@]} ]]; then
        
            package=${options[$((index-1))]}
            echo "\n[*] Installing $package..."
            sudo pacman -S $package
        
        else

            echo "Invalid option: $index"
        
        fi
    
    done


else

    echo -e "\n[-] Installation aborted.\n"
    exit 1

fi
