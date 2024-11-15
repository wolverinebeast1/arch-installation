
# Arch Linux Base Installation Guide

This file contains the command sequence needed to install the base Arch Linux. The approach is suitable for those who are installing arch linux
in `VirtualBox` but it also works well if you are installing in on hardware.

## Table of Contents
- [Keyboard Setup](#keyboard-setup)
- [Connect to Wi-Fi (Optional)](#connect-to-wi-fi-optional)
- [Partitioning Disks](#partitioning-disks)
- [Formatting and Mounting Partitions](#formatting-and-mounting-partitions)
- [Installing the System](#installing-the-system)

---

## Keyboard Setup


Set up your keyboard layout. To find the correct keyboard layout, refer to the instructions in the Arch Linux documentation.


To search for the available keymaps, you can use the following command:
```bash
#Search for available keymaps
localectl list-keymaps
```
```bash
#In my case, I will be using the Spanish keyboard layout
loadkeys es
```
---
## Connect to Wi-Fi (Optional)
```bash
iwctl
device list
station your_device_name scan
station your_device_name get-networks
station your_device_name connect SSID
ping google.com
```
## Partitioning Disks
In this section of the installation we are going to use a very basic approach to partition disks without disk encryption.

Partitions commonly look something like this:

- `/dev/nvme0n1p1`
- `/dev/nvme0n1p2`
- `/dev/sda`
- `/dev/sdb`

To find out easily the partitions you can use the `lsblk` command , it will look something like this:

<img src="/images/lsblk.PNG" alt="rice" align="center" width="500px">

After finding out what partitions you have it's time to partition them and format them.
```bash
#In my case it's /dev/sda
cfdisk /dev/sda
```
Here’s a short video on how the partitioning process is done: https://www.youtube.com/watch?v=GQvTQZ9Ft8w
## Formatting and Mounting Partitions

After partitioning the disks, we will proceed to format them and mount them.

```bash
#Formatting as FAT32
mkfs.fat -F32 /dev/sda1
#Formatting as ext4 
mkfs.ext4 /dev/sda2
#Creating a boot directory for EFI
mkdir -p /mnt/boot/efi
#Mounting the efi partition
mount /dev/sda1 /mnt/boot/efi
#Mounting the linux partition
mount /dev/sda2 /mnt 
```

## Installing the system
We have already created, formatted, and mounted our partitions. Now it's time to install the actual system.

Here, the installation part is mostly automated. The script will handle all the configuration and install the necessary packages. After it finishes, we can reboot and start using our system.
```bash
#This command installs the base packages we need 
pacstrap /mnt base base-devel linux linux-firmware git vim
#Generate fstab table
genfstab -U /mnt >> /mnt/etc/fstab
#Checks if everything is in order
cat /mnt/etc/fstab
#Enter the arch configuration
arch-chroot /mnt
#Clone this repo to download the installation script
git clone https://github.com/wolverinebeast1/arch-installation
#Change directory
cd arch-installation/
#Give permissions
chmod +x install_arch.sh
#Run the installation script
./install_arch.sh
```



