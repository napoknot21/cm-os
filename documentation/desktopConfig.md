# DESKTOP CONFIG FOR INSTALLING PACKAGES

First we need a desktop environemet so  first :
```
sudo pacman -S xorg xorg-server xorg-xinit
```

We need audio so we install:
```
sudo pacman -S pulseaudio pavucontrol
```

Install some plugins for a better sound quality !
```
sudo pacman -S alsa-firmware alsa-plugins
```

> NOTE !
> > If ever pulseaudio doesn't detect your sound card, try to install this:
> > ``` 
> > sudo pacman -S sof-firmware alsa-ucm-conf 
> > ```
> > That's normally fix your pb of audio
> 
> plus, you can install a package for improving the sound expirence !
> ```
> sudo pacman -S alsa-oss
> ```
> Then, we load some kernel modules !
> ```
> sudo modprobe snd-seq-oss snd-pcm-oss snd-mixer-oss
> ```


Install fonts (yes, bc the default ones are not really cutes)
```
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts
```

If you want other fonts, you can find them [here](nerdfonts.com) or install
```
paru -S nerd-fonts-complete
```
> This going to install all nerd-fonts fonts


For emojis and/or special characters, install :
```
sudo pacman -S noto-fonts-emoji noto-fonts-cjk
```

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
