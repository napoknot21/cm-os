#!/bin/sh

home = $HOME


sys_pc = $'ls /sys/firmware/efi'


n -sf /usr/share/zoneinfo/Europe/Paris /etc/localtime
hwclock --systohc
sed -i 