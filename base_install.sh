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

locale-gen

#Generating US locale , if u not english than learn it (:
echo "LANG=en_US.UTF-8" >> /etc/locale.conf



#to search your keyboard use -> "localctl list-keymaps | grep your_fucking_key_map"

#Spanish keyboard
echo "KEYMAP=sunt5-es" >> /etc/vconsole.conf

#Variable that stores your hostname
read -p 'Type the of the hostname: ' hostname_var

echo "$hostname_var" >> /etc/hostname

echo "127.0.0.1 localhost" >> /etc/hosts

echo "::1	localhost" >> /etc/hosts

echo "127.0.1.1 $hostname_var.localdomain $hostname_var" >> /etc/hosts

#Password for your root user
read -p 'Type the password for your root user: ' root_passwd

echo root:$root_passwd | chpasswd

#install the packages

pacman -S grub efibootmgr networkmanager pulseaudio dialog mtools dosfstools os-prober base-devel firefox kitty sddm 


#install nvidia packages , if u re using amd gpu , I dont give a fuck lol buy nvidia
#pacman -S --noconfirm nvidia nvidia-utils nvidia-settings



#grub installation
grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB

#generating grub-config
grub-mkconfig -o /boot/grub/grub.cfg

#enable services
systemctl enable NetworkManager
systemctl enable sddm

#Name of the user
read -p 'Type your username ' user_name
useradd -m $user_name

#Password for the new user
read -p 'Type the password for your new user: ' user_passwd
echo wolverine:$user_passwd | chpasswd

#Adding root permissions for the new users
echo "$user_name ALL=(ALL) ALL" >> /etc/sudoers.d/wolverine

#Final message
printf "\nOk ufak u re done xd now reboot your machine lol\n"
