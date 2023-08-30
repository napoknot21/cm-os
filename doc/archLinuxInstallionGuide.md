# Arch Linux installation guide 

This guide is a summary and customization of the installation guide from [archlinux.org](https://archlinux.org). If you want to consult the official guide, click [here](https://wiki.archlinux.org/title/installation_guide).
 

## First steps

### Prerequisites

This section is only applicable if you're installing Arch Linux on physical hardware.

1. USB drive
2. Backup of your files

> Notes
> 1. Ensure the USB drive you are using to flash the Arch ISO has at least 8GB of space. 
> 2. It's good practice to backup all your files. If something goes wrong during installation, you could permanently lose them. Proceed with caution!

### Dual-Boot Prerequisites

A common issue during dual-boot installations is related to the GRUB bootloader. To avoid this, make sure that your boot/EFI partition is at least 250MB (Ideally, make it 1GB).

For Windows users, your `EFI System Partition` partition is typically 100MB, so you will need to increase this. If you're not sure how to do it, refer to this [tutorial](https://youtu.be/HDa4hfGX5xE?feature=shared).


### Donwload the ISO file

Download the latest version of the Arch Linux ISO file from the official website. To do so, follow these steps:

1. Go to [archlinux.org](https://www.archlinux.org)
2. Navigate to **Download**
3. Search and select a server close to your timezone or country
4. Download the `archlinux-XXXX.XX.XX-x86_64.iso` file

> **Note:**
> The "X"s denote the date of the latest version.

Now, we need to flash the ISO file in a USB driver.


### Flashing the USB Driver

>  This subsection is only applicable for installations on physical machines.

Before you begin, **backup your USB drive** because you'll need to format it to flash the ISO file.

On Windows, follow these commands to format your USB drive. 

Open a `cmd` or `PowerShell` window as an `administrator`
```
C:\WINDOWS\system32>
``` 

Going to use the ```diskpart``` program !
```
C:\WINDOWS\system32> diskpart
```

Once you've entered this command, you should see a new *interface* that looks like this:
```
Microsoft DiskPart version XX.X.XXXXX 
Copyright: (c) 1999-2023 Microsoft Corporation.
On-computer: YYYY

DISKPART> 
```
> The "X"s are numbers so taht means a version and "YYYY", a name

Start by listing all available hard disks:
```
DISKPART> list disk
```

This command will display all the hard disks depending on your hardware configuration. For example:
```
  Disk ###    Status       Size       Free        Dyn     GPT
  --------    ---------    -------    -------     ---     ---
  Disk 0      online        476 GB     101 MB              *
  Disk 1      online       7800 MB    7784 MB
```
> In this example, my USB drive (Disk 1) is clearly the one with a size of 7784MB (~8GB), and the other (Disk 0) is my SSD.

Now, identify your USB drive (e.g., `Disk 1`) in order to select it
```
DISKPART> select disk 1
```
> Again, your disk number will depend of your hardware config, so be careful !

Make sure you've selected the correct disk to avoid data loss! so run the ```list disk``` command
```
  Disk ###    Status       Size       Free        Dyn     GPT
  --------    ---------    -------    -------     ---     ---
  Disk 0      online        476 GB     101 MB              *
* Disk 1      online       7800 MB    7784 MB
```
> Notice that an asterisk (*) appears before `Disk 1`, indicating that it is the selected disk !

Once the correct disk is selected, let's clean the device
```
DISKPART> clean
```

Next, create a new partition for your USB drive:
```
DISKPART> create partition primary
```

Finally, let's format the device !
```
DISKPART> format fs=fat32 quick
```

You should see a message saying the volume was successfully formatted. Exit the CMD.

Now, to flash the ISO file to your USB drive, use **Balena Etcher**. Download and install it from the [official site](https://www.balena.io/etcher/), then follow the steps:

1. **Flash from file:** Select the Arch Linux ISO file
2. **Select a target:** Choose your USB drive
3. **Flash!**


### Creating partition for Arch Linux

Skip this section if you are not setting up a *dual-boot* system and go directly to **Installation** section.
> TODO !

## Installation

### BIOS

Connect your USB drive to your laptop or PC, and then shut it down.

Upon restarting, make sure to access your `BIOS` interface. The method for accessing BIOS will depend on your device's brand. For more details, see [here](https://oliz.io/blog/2021/bios-keys.html).

Once inside the BIOS, disable `Secure Boot mode`. The exact method for doing this will vary as BIOS interfaces differ between manufacturers. Generally, you can find this option in the `Security` or `Boot` sections.

Additionally, change the boot order to place the USB device in the first position.

Once these steps are completed, you're officially ready to begin the installation!

### Layout config

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

### Encryption

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

### Mounting the partition

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

### Arch-chroot !

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
hooks = (base udev autodetect modconf kms keyboard keymap consolefont block filesystems encrypt lvm2 fsck)
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


**Author**: Charly Martin Avila (Napoknot21) 2023
