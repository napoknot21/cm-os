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

