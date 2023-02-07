# cm-os
Custom settings for Arch-linux including a desktop environment (window manager) and stable version.

**Note: The script is not finished yet. Instead, the guides and docs are up to day !**

## Pre requisites
The CM-OS just need to a basic partition disk in order to complete the base installation of arch linux. For that, check in the [documentation](./documentation) our cutomised arch installation [guide](./documentation/archLinuxInstallationGuide.md).

The following script will allow you to install a customised version of any desktop environement avalaibles in this repo (qtile, xmonand, openbox, gnome, kde, etc)

For more details about the final result, check the images directory. That may help you to choose the desktop (or desktops) you like the most ! 


## Installation 
In order to install the CM-OS, were are going to create a dot-repository in our home directory (```/home/[YOUR_USER]```)
```
mkdir .repos
```
We enter to the directory created
```
cd .repos
```
Then, we clone this repository inside the directory
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
In the [documentation](./documentation) directory, you will find a detailed guides if you want to build these customised desktops environement by your own !

