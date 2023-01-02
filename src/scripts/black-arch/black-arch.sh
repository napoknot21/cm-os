#!/bin/sh

# Repositories from Black-arch (pentesting and hacking utils)

echo "[!] BLACK ARCH TOOLS ! \n"

echo -n "Do you want to have acces to Black-arch repositories ? [y/n]: "
read rep

if [[ $rep = [Yy] ]]; then

	echo "[*] Installing acces to black arch repos..."
	cd ~/.repos
	mkdir black-arch && cd black-arch
	curl -o https://blackarch.org/strap.sh
	chmod +x strap.sh
	sudo ./strap.sh

	#Installing basic tools
	echo "[*] Installing the basic tools..."
	sudo pacman -S nmap whatweb wfuzz wireshark-cli wireshark-qt exploitdb smbclient smbmap evil-winrm

	echo "[*] Basic black arch tools successfully installed !"
        sleep 1

	echo -n "Do you want to install more interesting black arch packages ? [y/n]: "
	read rep1

	if [[ $rep1 == [yY] ]]; then
		sudo pacman -S metasploit ettercap responder tcpdump gobuster dirbuster crackmapexec sqlmap seclists
		echo "[*] Basic black arch tools successfully installed !"
		sleep 1

		echo "Do you want to install advanced tools for pentesting/hacking ? [y/n]: "
		read rep2

		if [[ $rep2 == [yY] ]]; then
			sudo pacman -S wpscan wafw00f sploitctl rsync redis openvpn nikto hash-identifier fcrackzip burpsuite aircrack-ng perl-image-exiftool venom
			#paru -S mkpasswd [OBSOLET PCKG]

			echo "[*] Advanced black arch tools installed successfully !"
			sleep 1
		else
			echo "[*] Advanced black arch tools installed successfully !"
			sleep 1
		fi
	else 
		echo "[*] Basic black arch tools successfully installed !"
		sleep 1
	fi

else
	echo "[*] Process passed away"
	sleep 1
fi

echo "[*] Moving on to the next step..."

# Author @napoknot21
