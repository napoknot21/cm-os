# DESKTOP CONFIG FOR INSTALLING PACKAGES

First we need a desktop environemet so  first :
```
sudo pacman -S xorg xorg-server xorg-xinit
```

We need audio so we install:
```
sudo pacman -S pulseaudio pavucontrol
```

> NOTE !
> > If ever pulseaudio doesn't detect your sound card, try to install this:
> > ``` 
> > sudo pacman -S sof-firmware alsa-ucm-conf 
> > ```
> > That's normally fix your pb of audio
> 
>

Install fonts (yes, bc the default ones are not really cutes)
```
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts
```

If you want other fonts, you can find them [here](nerdfonts.com)


# Paru
Sometimes, we are going to need some packages from AUR arch repos, so we are going to do :
First, create a directory where all repos going to be clone
```
mkdir ~/.repos && cd ~/.repos
```
Then, we clone the paru repo in ```.repos``` 
```
git clone https://aur.archlinux.org/paru.git
```
Then, we enter to the directory
```
cd paru-bin
```
Once there, build and install Paru AUR helper by
```
makepkg -si
```

# Black Arch
For hacking utils, you can install basic packages availables on arch linux repositories:
```
sudo pacman -S net-tools nmap ettercap metasploit wiresharck-qt wireshark-cli
```
If you want more utils for hacking, so we a bigger repository ! we are going to add black arch repos to our pacman !
> This action NOT going to install all black arch packages, but we're be able to install any util from their repos !
``` 
cd ~/.repos
```
We create a directory
```
mkdir black-arch && cd black-arch
```
Once in the directory, we exec:
```
curl -O https://blackarch.org/strap.sh
```
Normally, we generate the file ```strap.sh```
So, we give it permission for execution
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
>  blackarch is up to date
> ````
> So, now we can install any black arch util !
# Alacritty
We are to config alacritty in order to customize it

First, we need a program that changes opacity, so 
```
sudo pacman -S picom
```
Then, we need to modify ```~/.config/alacritty/alacritty.yml``` (if the file or directory does not exit, then you have to create it !)
```
window :
  opactiy: 0.9
```
Finally, close all active terminals and voilà !

# Rofi
Rofi is window menu selector. 
We install rofi bu
```
sudo pacman -S rofi
```

We install some nice icons
```
sudo pacman -S papirus-icon-theme
```

Whe chose a theme
```
rofi-select-theme
```

We modify the ```~/.config/rofi/config.rasi``` as followed
```
onfiguration {
    modi: "window,drun,ssh,combi";
    ssh-client : "ssh";
    icon-theme : "Papirus";
    combi-modi: "window,drun,ssh";
    show-icons : true;
}
@theme "/usr/share/rofi/themes/DarkBlue.rasi"
```