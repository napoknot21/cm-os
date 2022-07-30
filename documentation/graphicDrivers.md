# Graphics Drivers
This section helps you to install manually best and necessary intel/AMD/Nvidia drivers in order to get a better graphic experience on arch linux

## Basic commands
The basic graphic package is ```mesa```, run :
> Attention: May the package is already installed, in this case you are free to reinstall it or not
```
sudo pacman -S mesa
```

## Intel
For not modesty mode, install the following packages
```
sudo pacman -S ocl-icd intel-compute-runtime xf86-video-intel intel-media-driver 
```
Then, modify the ```/etc/modprobe.d/i915.conf``` file (if it does not exit, create it) and put :
```
options i915 enable_guc=2 enable_fcb=1 fasboot=1
```
Finally, modify the ```/etc/X11/xorg.conf.d/20-intel.conf``` (if it does not exit, create it) and put
```
Section "Device"
	Identifier "Intel Graphics"
	Driver "Intel"
EndSection
```


## Vulkan API
for those packages, it's necessary to uncomment a line from the ```/etc/pacman.conf``` file, then
```
[multilib]
include = /etc/pacman.d/mirrorlist
```
Once done, we synchronise the package manager
```
sudo pacman -Syy
```
We're supposed to have an output like this:
```
:: Synchronizing package databases...
 core is up to date
 extra is up to date
 community is up to date
 multilib is up to date
```

### Vulkan intel
We install the vulkan intel packages
```
sudo pacman -S vulkan-intel vulkan-icd-loader
```

### Vulkan AMD
Install the vulkan amd packages
```
sudo pacman -S vulkan-radeon vulkan-icd-loader
```

## Nvidia

Install the packages
```
sudo pacman -S nvidia-dkms nvidia-utils nvidia-settings
```
