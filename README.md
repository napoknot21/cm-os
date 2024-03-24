# cm-os

Custom settings for Arch-linux including a desktop environment (window manager) and stable version.

**Note: The script is not finished yet. Instead, the guides and docs are up to day !**

## Pre requisites

The CM-OS just need a basic installation of arch linux !

If you are new and don't know how to install Archlinux, check my customized Arch Linux installation guide [here](./doc/archLinuxInstallionGuide.md).

The following script will allow you to install a customized version of any desktop environment available in this repo (qtile, xmonad, openbox, gnome, kde, etc).

For more details about the final result, check the images directory. That may help you to choose the desktop (or desktops) you like the most !
> TODO: Not images yet

And finally, be sure to be in the `wheel` group because you will install a few packages!


## Installation 

Clone this repository in your ```~``` (or `$HOME`) directory or wherever you want
```
git clone https://github.com/napoknot21/cm-os.git
```

We enter to the cloned directory
```
cd cm-os
```

Assign execute privileges to the ```installer.sh``` file in order to download all needed packages
```
chmod u+x installer.sh
```

Finally, execute the installer script
```
./installer.sh
```

## Details

In the [documentation](./doc/) directory, you will find detailed guides if you want to build these customized desktop environments by yourself !