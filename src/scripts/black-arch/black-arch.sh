#!/bin/sh

# Repositories from Black-arch (pentesting and hacking utils)

echo -e "[!] BLACK ARCH TOOLS ! \n"

# Check for curl installation
if ! command -v curl &> /dev/null; then

    echo -e "\n[*] curl not found! Installing...\n"
    sudo pacman -S curl
    
fi

echo -n "Do you want to have access to Black-arch repositories? [y/n]: "
read rep

if [[ $rep = [Yy] || -z $rep ]]; then

    echo -e "\n[*] Installing access to black arch repos...\n"

    # Check for ~/.repos directory and navigate to it
    mkdir $HOME/.repos && cd $HOME/.repos

    # Check for black-arch directory or create it and navigate
    mkdir -p black-arch && cd black-arch

    # Fetch strap.sh
    curl -O https://blackarch.org/strap.sh

    chmod +x strap.sh
    sudo ./strap.sh

    # Installing basic tools
    echo -e "\n[*] Installing the basic tools...\n"

    sudo pacman -S nmap whatweb wfuzz wireshark-cli wireshark-qt exploitdb smbclient smbmap evil-winrm
    sudo usermod -aG wireshark $USER

    echo -e "\n[+] Basic black arch tools successfully installed !\n"
    sleep 1

    echo -ne "\nDo you want to install more interesting black arch packages? [y/n]: "
    read rep1

    if [[ $rep1 == [yY] || -z $rep1 ]]; then
        
		sudo pacman -S ettercap responder tcpdump gobuster dirbuster crackmapexec sqlmap seclists net-tools arp-scan bruteforce-luks
        
		echo -e "\n[*] Basic black arch tools successfully installed!\n"

        echo -en "\nDo you want to install advanced tools for pentesting/hacking? [y/n]: "
        read rep2

        if [[ $rep2 == [yY] || -z $rep2 ]]; then

            sudo pacman -S wpscan wafw00f sploitctl rsync redis openvpn nikto hash-identifier fcrackzip burpsuite aircrack-ng perl-image-exiftool venom macchanger

            echo -e "\n[+] Advanced black arch tools installed successfully!\n"
            
        else

            echo -e "\n[-] Skipping advanced tools installation.\n"
            
        fi

    else

        echo -e "\n[+] Basic black arch tools successfully installed!\n"
        sleep 1
    
	fi

else

    echo -e "\n[*] Process passed away\n"
    sleep 1

fi

# Author @napoknot21