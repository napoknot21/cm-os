# BSPWM config

This file will explain step by step how to set up this desktop environment !

Let's start by installing the `bspwm` desktop and `sxhkd` !
```
sudo pacman -S bspwm sxhkd
```
> Note : 
> The `sxhkd` package will be useful for key shortcuts !


Once done, we need to create a directory where to apply our changes
```
mkdir ~/.config/bspwm && mkdir ~/.config/sxhkd
```

It's probably that the bspwm config file won't be create automatically, for that, let's check the original github repo [here](https://github.com/someone/bspwm)

Let's dig into the `examples` directory ! you will find there the `bspwmrc` `sxhkdrc` config files ! Let's download them into their correspond directories and give the execution rights !
```
chmod +x ~/.config/bspwm/bspwmrc && chmod +x ~/.config/sxhkd/sxhkdrc
```

