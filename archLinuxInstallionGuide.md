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
> For exemple, we can run something like this :
> ```
> [iwd]# station wlan0 scan
> ```
>

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

formating partition
```
mkfs.fat -F32 /dev/EFI_PARTITION
```
```
mkswap /dev/SWAP_PARTITION
```
```
swapon /dev/SWAP_PARTITION
```
```
mkfs.ext4 /dev/HOME_PARTITION
```
We encrypt the disk
```
cryptsetup -y -v [or --user-random] luksFormat /dev/ROOT_PARTITION 
```
Then, we have to open the encrypted partition
```
cryptsetup open /dev/ROOT_PARTITION cryptroot
```
Now we can formate it
```
mkfs.ext4 /dev/mapper/cryptroot
```
we mount all partitions
```
mount /dev/mapper/cryptroot /mnt
```
```
mkdir /mnt/home
```
```
mount /dev/HOME_PARTITION
```
```
mkdir /mnt/boot
```
```
mount /dev/EFI_PARTITION /mnt/boot
```

### installing base packages
We have to install the linux kernel :
```
pacstrap /mnt base linux linux-firmware base-devel git vim grub efibootmgr nano
```
Depending of your micro processor , install :
``` pacman -S intel-ucode``` or ``` pacman -S amd-ucode```

We generate the file system table
```
genfstab -U /mnt >> /mnt/etc/fstab
```

we verify it's ok
```
cat /mnt/etc/fstab
```

changing to root
```
arch-chroot /mnt
```

we link the local clock
```
ln -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
```
```
hwclock --systohc
```
we generate locale.gen and we uncomment en_US.UTF-8 and all languages you want
```
nano /etc/locale.gen
```

We generate the locale generation
```
locale-gen
```

we config the langugae
```
echo "LANG=fr_FR.UTF-8" > /etc/locale.conf
```

we config the keymap
```
echo "KEYMAP=fr" > /etc/vconsole.conf
```

We name our device
```
echo "NAME OF YOUR PC or LAPTOP" > /etc/hostname
```

we modify the localhost port
```
nano /etc/hosts
```
>we write inside /etc/hosts
> ```
> 127.0.0.1   localhost
> ::1         localhost
> 127.0.1.1   [NAME OF YOUR DEVICE].localhost     [NAME OF YOUR DEVICE]
> ```

We gieve a password for the root user
> We enter 2 times the password
```
passwd
```

we install some packeges
```
pacman -S networkmanager network-manager-applet bluez bluez-utils pulseaudio pulseaudio-bluetooth alsa-utils dosfstools mtools cups
```
We installed arch as encrypted , so let's modify some files :
```
nano /etc/mkinitcpio.conf
```
> Here we modify like this : 
> > ["..." means that we don't touch those values]
> ```
> hooks = ( ... autodected keyboard keymap ... block encrypt filesystem fsck)
> ```

we relance la config
```
mkinitcpio -p linux
```

we install grub
```
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --recheck
```

we modify the gub file to acces efibootmgr to detect windows
> last line: we uncomment last line
```
nano /etc/default/grub
```

we config grub
```
grub-mkconfig -o /boot/grub/grub.cfg 
```

we ckeck 
```
blkid
```

then we copy de UUID of aour /dev/ROOT_PARTITION 
> we modify again the grub deagult file

we modifiy ```GRUB_CMDLINE_LINUX``` By
```
GRUB_CMDLINE_LINUX="cryptdevice=UUID=[THE UUID ROOT_PARTITION]:cryptroot root=/dev/mapper/cryptroot"
```

We remake the grub config
```
grub-mkconfig -o /boot/grub/grub.cfg
```

we allow some services
```
systemctl enable NetworkManager
```
```
systemctl enable bluetooth
```
```
systemctl enable cups 
```

we create a local user
```
useradd -m charly
```
```
passwd charly 
```
> we enter 2 times de password for the user
```
usermod -aG wheel,storage,video,audio,optical charly
```

we install sudo
```
pacman -S sudo
```

we modify /etc/sudoers
```
nano /etc/sudoers
```

we uncomment this line:
```
%wheel ALL=(ALL:ALL) ALL
```

We've finished !

exit of arch(chroot
```
exit
```

to unmount the partition
```
umount -a
```