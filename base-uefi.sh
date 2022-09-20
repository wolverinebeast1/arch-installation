#!/bin/bash

#Before running this script: 
#1)Make sure you already did the disk partition , formatted the disks partitions and mounted them.
#2) After disk partitions make sure you executed "pacstrap" utility to install base packages
#3) Enter arch-chroot /mnt
#4) RUN THIS SCRIPT

#    _    ____   ____ _   _ ____   ____ ____  ___ ____ _____
#  / \  |  _ \ / ___| | | / ___| / ___|  _ \|_ _|  _ |_   _|
#  / _ \ | |_) | |   | |_| \___ \| |   | |_) || || |_) || |
#/ ___ \|  _ <| |___|  _   ___) | |___|  _ < | ||  __/ | |
#/_/   \_|_| \_\\____|_| |_|____/ \____|_| \_|___|_|    |_|



ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
hwclock --systohc
locale-gen
echo "LANG=en_US.UTF-8" >> /etc/locale.conf
echo "KEYMAP=es" >> /etc/vconsole.conf
echo "arch" >> /etc/hostname 
echo "127.0.0.1 localhost" >> /etc/hosts
echo "::1       localhost" >> /etc/hosts
echo "127.0.1.1 arch.localdomain arch" >> /etc/hosts
echo root:password | chpasswd


#packages to install
pacman -S grub efibootmgr networkmanager network-manager-applet dialog wpa_supplicant mtools dosfstools base-devel linux-headers xdg-user-dirs xdg-utils gvfs gvfs-smb nfs-utils inetutils dnsutils bluez bluez-utils cups hplip alsa-utils pipewire pipewire-alsa pipewire-pulse pipewire-jack bash-completion openssh rsync reflector acpi acpi_call tlp virt-manager qemu qemu-arch-extra edk2-ovmf bridge-utils dnsmasq vde2  iptables-nft ipset  os-prober ntfs-3g terminus-font



#amd drivers
# pacman -S --noconfirm xf86-video-amdgpu
 #nvidia drivers
# pacman -S --noconfirm nvidia nvidia-utils nvidia-settings


grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB #change the directory to /boot/efi if you mounted the EFI partition at /boot/efi

grub-mkconfig -o /boot/grub/grub.cfg #generate config file of grub


#Services to enable

systemctl enable NetworkManager
systemctl enable bluetooth
systemctl enable cups.service
systemctl enable sshd
systemctl enable reflector.timer
systemctl enable fstrim.timer
systemctl enable libvirtd


useradd -m tux #if you wanna give other user name , just change it
echo tux:password | chpasswd
usermod -aG libvirt tux

echo "tux ALL=(ALL) ALL" >> /etc/sudoers.d/tux #allows executing sudo priveleges to the normal user


printf "\e[1;32mDone! Type exit, umount -a and reboot.\e[0m"




