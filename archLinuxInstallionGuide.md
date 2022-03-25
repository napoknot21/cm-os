# Arch Linux installation guide 

This guide is a summary and customization of the installation guide of [archlinux.org](archlinux.org) so if you want to check the offical guide click [here](https://wiki.archlinux.org/title/installation_guide)

## Prerequisites
First of all, you need to download the lastest version of ISO arch linux file in the official website.

**Before to start, I advice you to make a back up of all your windows data**: It's always important to do it before to start any change in the system !

### Creating a separate partition/Volume for Arch Linux
> If you are not in a Dual Boot case, skip this part



### Donwload the ISO file
Go to [archlinux.org](archlinux.org) -> Donwload -> *search & select a server* (make sure to select a server near to your zone time or country) -> download the ```archlinux-XXXX.XX.XX-x86_64.iso``` file (X means the date of the lastest version)


Now, we need to flash the ISO file in a USB driver, so make sure to have one that has at least 8Go


### Flashing the USB Driver

Before to start, **make sur to amke a back up of your USB driver files**: It's necessary to format the driver in order to flasing the ISO file.

Once done, format your USB device.

We are going to use **Balena Etcher** for flashing the ISO file in our USB Driver.
if you are on windows, go to the [official site](https://www.balena.io/etcher/) and download & install the program.

After that click on *Flash from file* (Select the ISO arch linux file) -> *select a target* (select your USB Driver) -> Flash !


## Installation

We start changing the keyboard layout (language) if yours is not english, for exemple:
> to check the list of all keyboard layouts and find out yours, do ``` localectl list-keymaps```
```
loadkeys fr_latin1
```

Then We need internet, run the followinf command
```
iwctl
```

