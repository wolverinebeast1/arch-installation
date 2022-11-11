#!/bin/bash

#Autor: WolverineBeast1

# ____            _       _   
#/ ___|  ___ _ __(_)_ __ | |_ 
#\___ \ / __| '__| | '_ \| __|
# ___) | (__| |  | | |_) | |_ 
#|____/ \___|_|  |_| .__/ \__|
#                  |_|     



#Arch-install alternative, without doing nothing(sitting on your chair lol)


#boring configuration of the system
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime

hwclock --systohc

sed -i '171s/.//' /etc/locale.gen

locale.gen

#Generating US locale , if u not english than learn it (:
echo "LANG=en_US.UTF-8" >> /etc/locale.conf



#to search your keyboard use -> "localctl list-keymaps | grep your_fucking_key_map"

echo "KEYMAP=es" >> /etc/vconsole.conf

echo "wolverine" >> /etc/hostname

echo "127.0.0.1 localhost" >> /etc/hosts

echo "::1	localhost" >> /etc/hosts

echo "127.0.1.1 wolverine.localdomain wolverine" >> /etc/hosts

echo root:passwd | chpasswd

#install the packages

pacman -S grub efibootmgr networkmanager pulseaudio alsa-utils dialog mtools dosfstools os-prober base-devel firefox kitty alactritty sddm 


#install nvidia packages , if u re using amd gpu , I dont give a fuck lol buy nvidia
pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

mkdir -p /boot/efi

mount /dev/sda2 /boot/efi

#grub config
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

grub-mkconfig -o /boot/grub/grub.cfg

#enable services
systemctl enable NetworkManager
systemctl enable sddm

useradd -m wolverine

echo wolverine:password | chpasswd

echo "wolverine ALL=(ALL) ALL" >> /etc/sudoers.d/wolverine

printf "Ok ufak u re done xd now reboot your machine lol"
