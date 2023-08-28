# Arch Linux installation guide 

This guide is a summary and customization of the installation guide of [archlinux.org](archlinux.org) so if you want to check the offical guide click [here](https://wiki.archlinux.org/title/installation_guide)

## General Prerequisites
First of all, it's good practice to back up all your files. Indeed, if something goes wrong, you could permanently delete them, especially since we are going to modify the hard disk. So, be careful!
Next, you need to download the latest version of the Arch Linux ISO file from the official website. If you don't know how to do this, you can find instructions on internet or any site :)

### Dual-Boot Prerequisites
One common issue during dual-booting arises when installing GRUB (you'll see more about this later). To avoid this, ensure that the size of your boot/EFI partition is greater than 250 MB; ideally, 1 GB is better, although the smaller size should suffice. For Windows users, the size of your `SYSTEM` partition is typically 100 GB. You'll need to increase this. If you're unsure how to go about it, you can refer to this [tutorial](https://youtu.be/HDa4hfGX5xE?feature=shared).


### Creating a separate partition/Volume for Arch Linux
> If you are not in a **Dual Boot** case, skip this part and go directly to **Installation** section



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
> 64 bytes from archlinux.org ... ... 
> 64 bytes from archlinux.org ... ...
> 64 bytes from archlinux.org ... ...  
>```
> ```CTRL + C ``` to intteromp the loup

If all it is ok, so let's continue !

### Partitioning the disk !
To check all disks and their partitons :
```
lsblk
```

Now, we are going to partition the disk
```
cfdisk
```

> We're going to choose this config
> > This config is based of 100Go so, if your hard disk or partition has not 100Go do a simple math calculus to know appromitaly how space you have to give to all partitions
> ```
> (partition of 100G)
> -> one EFI partition (1G)  [if you are not on dual boot]
>-> one Root&Home partition (95G)
>-> swap partition (4G) [If you have more than 8Go ram, 2Go ]
>```

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

Now we are going to encrypt the disk in order to protect all (personal) files and data
```
mkfs.ext4 /dev/ROOT_HOME_PARTITION
```
We encrypt the disk
> We enter twice a password 
```
cryptsetup -y -v [or --user-random] luksFormat /dev/ROOT_HOME_PARTITION 
```


Then, we have to open the encrypted partition
> I named "cryptArch" but you can name it as you want
```
cryptsetup luksOpen [or just open] /dev/ROOT_HOME_PARTITION cryptArch
```

We create the physic volume
```
pvcreate /dev/mapper/cryptArch
```

Now, we're going to create a group volume for encrypt the root and the home partition
> Again, I named archGroup , but you can name it as you want
```
vgcreate archGroup /dev/mapper/cryptArch
```

We create the logic Volumes for root
```
lvcreate -L 60G archGroup -n root
```
And for home
```
lvcreate -l 100%FREE archGroup -n home
```

Once done, we have to finish to format the partitions
```
mkfs.ext4 /dev/archGroup/root
```
```
mkfs.ext4 /dev/archGroup/home
```

We finally mount all partitions !
```
mount /dev/archGroup/root /mnt
```
```
mkdir /mnt/home && mount /dev/archGroup/home /mnt/home
```
```
mkdir /mnt/boot && mount /dev/EFI_PARTITION /mnt/boot
```


### installing base packages
We have to install the linux kernel :
```
pacstrap /mnt base linux linux-firmware base-devel git vim grub efibootmgr os-prober nano [intel-ucode]
```
> Depending of your micro processor , install :
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
echo "NAME_OF_YOUR_PC or LAPTOP" > /etc/hostname
```
> ex. echo "mylaptop" > /etc/hostname


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

We set a password for the root user
> We enter 2 times the password
```
passwd
```

we install some packages
```
pacman -S networkmanager network-manager-applet bluez bluez-utils pulseaudio pulseaudio-bluetooth alsa-utils dosfstools mtools cups
```

We need to install this package for encryption
```
pacman -S lvm2
```


Then, let's modify the HOOKS in ```/etc/mkinitcpio.conf```:
> We're supposed to have this :
```
hooks = (base udev autodetect modconf block filesystems keyboard encrypt lvm2 fsck)
 ```

we relance la config
```
mkinitcpio -p linux
```

we install grub
```
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB --recheck
```

we ckeck the UUIDs of our partitions by
```
blkid
```
we modify the grub default file ``` /etc/default/grub ```
> we copy de UUID of our ```/dev/ROOT_HOME_PARTITION``` from the out of ```blkid``` 
> >  and we uncomment ```GRUB_ENABLE_CRYPTODISK=y``` and ```GRUB_DISABLE_OS_PROBER=false```
>
> we modifiy ```GRUB_CMDLINE_LINUX```  By
```
GRUB_CMDLINE_LINUX="cryptdevice=UUID=[THE UUID ROOT_HOME_PARTITION]:cryptArch root=/dev/archGroup/root"
```

we config grub
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
useradd -m napoknot21
```
```
passwd napoknot21
```
> we enter 2 times de password for the user
```
usermod -aG wheel,storage,video,audio,optical napoknot21
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

exit of arch-chroot
```
exit
```

to unmount the partition
```
umount -a
```
Then turn off your machine by ```shutdown now``` and take of the usb-driver :


**Made and written by Charly Martin Avila (Napoknot21)**
