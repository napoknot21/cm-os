# Arch Linux installation guide 

This guide is a summary and customization of the installation guide of [archlinux.org](archlinux.org) so if you want to check the offical guide click [here](https://wiki.archlinux.org/title/installation_guide)

## Prerequisites
First of all, you need to download the lastest version of ISO arch linux file in the official website.


**Before to start, I advice you to make a back up of all your windows data**: It's always important to do it before make any change in the system !

### Creating a separate partition/Volume for Arch Linux
> If you are not in a Dual Boot case, skip this part and go directly to **Installation** section



### Donwload the ISO file
Go to [archlinux.org](https://www.archlinux.org) -> Donwload -> *search & select a server* (make sure to select a server near to your zone time or country) -> download the ```archlinux-XXXX.XX.XX-x86_64.iso``` file (X means the date of the lastest version)


Now, we need to flash the ISO file in a USB driver, so make sure to have one that has at least 8Go


### Flashing the USB Driver

Before to start, **make sur to amke a back up of your USB driver files**: It's necessary to format the driver in order to flasing the ISO file.

Once done, format your USB device.

We are going to use **Balena Etcher** for flashing the ISO file in our USB Driver.
if you are on windows, go to the [official site](https://www.balena.io/etcher/) and download & install the program.

After that click on *Flash from file* (Select the ISO arch linux file) -> *select a target* (select your USB Driver) -> Flash !


## Installation

### Basic configuration

We start changing the keyboard layout (language) if yours is not english, for exemple:
> to check the list of all keyboard layouts and find out yours, do ``` localectl list-keymaps```
```
loadkeys fr-latin1
```
Then, have to update the clock of our system
```
timedatectl set-ntp true
```
To check if the clock is synchronised :
```
timedatectl status
```
> In case of the local time is not the good one, run :
> ```
> timedatectl set-timezone YOUR_REGION/YOUR_CITY
> ```
> >*YOUR_REGION* : can be Europe, America, etc.
>
> >*YOUR_CITY* : Not necessary the city where you actually live, but the closest to yours.
>
> For exemple : ``` timedatectl set-timezone Europe/Paris``` 


### Internet !

Then we need internet, run the following command
```
iwctl
```

if you do not know your wireless device name, list all Wi-Fi devices:
```
[iwd]# device list 
```

Then, wz have to scan networks
> YOUR_DEVICE means the name of your Wi-fi device found on the last list
```
[iwd]# station YOUR_DEVICE scan
```

Once done, we list all the networks
```
[iwd]# station YOUR_DEVICE get-networks
```

Then, to connect a network
> WIFI means the network you've choosen to conect to internet
```
[iwd]# station YOUR_DEVICE connect WIFI
```

Once done, we need to get out
```
[iwd]# exit
```

Finally, we have to check we are connect to internet
```
ping archlinux.org
```
> We're supposed to have a similar result like this : 
> ```
> 64 bytes from ... ... 
> 64 bytes from ... ...
> 64 bytes from ... ...  
>```
> ```CTRL + C ``` to intteromp the boucle

If all it is ok, so let's continue !

### Partitioning the disk !
To check all disks and their partitons :
```
lsblk
```
> Depending of your disk type, the result could be like this :
> ```
> 
>
>
> ```

```
cfdisk (partition of 100G)
-> one EFI partition (1G)
-> one /home partition (35G)
-> the root [/] partition (60G)
-> swap partition (4G)
```
