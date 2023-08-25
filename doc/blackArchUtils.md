# Black Arch Utils

Following the arch linux's philosophy (only install the packages we need), this guide will help you to install the black-arch repos for pentesting or hacking proposes.

> Note: This action is NOT going to install ALL blackarch packages (+4G) This just allow you to install them !

## Black Arch Repo

Enter to the ```.repos``` directory which we were created before
```
cd  ~/.repos
```

Then, create a new directory called ```black-arch``` and enter in
```
mkdir black-arch && cd black-arch
```

Generate the ```strap.sh``` running
```
curl -O https://blackarch.org/strap.sh
```

Give it permission for execution
```
chmod +x strap.sh
```

Finally we execute the file
```
sudo ./strap.sh
```

And voilà, if you want to check all was ok, tape
```
sudo pacman -Sy
```
> We are supposed to have the following result
> ```
> :: Synchronizing package databases...
>  core is up to date
>  extra is up to date
>  community is up to date
>  blackarch is up to date**
> ````
> So, now we'll be able to install any black arch util !

## Installing best utils

Here, I list and explain some of best and basic utils for hacking and pentesting !

### Nmap
The basic tool for discovering open ports
```
sudo pacman -S nmap
```

### Whatweb
Basic tool for recognizing of http websites
```
sudo pacman -S whatweb
``` 

### Wfuzz
Tool for fuzzing websites and discover domains and subdomains
```
sudo pacman -S wfuzz
```

### Tshark
Intercepting traffic tool by console
```
sudo pacman -S wireshark-cli
```

### Wireshark
The same as the last tool but with a GUI
```
sudo pacman -S wireshark-qt
```

### Searchsploit (and exploitdb)
A linked database from [exploitdb](https://exploitdb.org) to search for vulnerabilities and exploits
```
sudo pacman -S exploitdb
```

### SmbClient
A ftp-like client tool to access SMB/CIFS resources on servers
```
sudo pacman -S smbclient
```

### smbmap
Another tool for ftp-like client access
```
sudo pacman -S smbmap
```

### EvilWinRm
Interactive Windows Shell for connecting to remote Windows servers
```
sudo pacman -S evil-winrm
```

### burpsuite
An integrated platform (proxy) for attacking web applications
```
sudo pacman -S burpsuite
```

## Some interesting packages and websites
Here we have some interesting packages and websites for pentesting and hacking.

One Liner command for the packages
```
sudo pacman -S metasploit ettercap responder tcpdump netcat gobuster dirbuster crackmapexec sqlmapp
```

Table of sites and github repos:

1. https://gtfobins.github.io/ (binaries privileges)
2. https://www.exploit-db.com/ (exploit database)
3. https://www.revshells.com/ (reverse shells)
4. https://crackstation.net/ (crack hashes & password)
5. https://github.com/veracode-research/rogue-jndi (rogue-jndi tool)
6. https://github.com/danielmiessler/SecLists (dictionaries for pentesting)

So, now we are ready !
