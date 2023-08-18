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


# Fonts
Let's Install many fonts (yes, bc the default ones are not really cutes)
```
sudo pacman -S ttf-dejavu ttf-liberation noto-fonts awesome-terminal-fonts
```

For emojis and/or special characters, install :
```
sudo pacman -S noto-fonts-emoji noto-fonts-cjk
```

If you want other fonts, you can find them [here](https://nerdfonts.com/) !


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
cd paru
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
rofi-theme-selector
```

We modify the ```~/.config/rofi/config.rasi``` as followed
```
configuration {
    modi: "window,drun,ssh,combi";
    ssh-client : "ssh";
    icon-theme : "Papirus";
    combi-modi: "window,drun,ssh";
    show-icons : true;
}
@theme "/usr/share/rofi/themes/DarkBlue.rasi"
```

# GTK themes
Config the ```~/.gtkrc2.0``` and ```~/.config/gtk-3.0/settings.ini``` files for having icons/themes

For the ```~/.gtkrc2.0```, write 
```
gtk-theme-name="Material-Black-Blueberry"
gtk-icon-theme-name="Material-Black-Blueberry-Suru"
gtk-font-name="Noto Sans 11"
gtk-cursor-theme-name="Breeze_Default"
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_SMALL_TOOLBAR
gtk-button-images=0
gtk-menu-images=0
gtk-enable-event-sounds=0
gtk-enable-input-feedback-sounds=0
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hintstyle="hintslight"
gtk-xft-rgba="rgb"
```

And for the ```~/.config/gtk-3.0/settings.ini``` , write
```
[Settings]
gtk-theme-name=Material-Black-Blueberry
gtk-icon-theme-name=Material-Black-Blueberry-Suru
gtk-font-name=Noto Sans 11
gtk-cursor-theme-name=Breeze_Default
gtk-cursor-theme-size=0
gtk-toolbar-style=GTK_TOOLBAR_BOTH_HORIZ
gtk-toolbar-icon-size=GTK_ICON_SIZE_SMALL_TOOLBAR
gtk-menu-images=0
gtk-enable-event-sounds=0
gtk-enable-input-feedback-sounds=0
gtk-xft-antialias=1
gtk-xft-hinting=1
gtk-xft-hinstyle=hintslight
gtk-xft-rgba=rgb
```
> Note: this settings are config with ```Material-Black-Blueberry``` theme !
