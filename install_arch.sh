#!/bin/bash

#Autor: WolverineBeast1

# ____            _       _   
#/ ___|  ___ _ __(_)_ __ | |_ 
#\___ \ / __| '__| | '_ \| __|
# ___) | (__| |  | | |_) | |_ 
#|____/ \___|_|  |_| .__/ \__|
#                  |_|     

#Please read the script carrefully and with calm

#Arch-install alternative, without doing nothing(sitting on your chair lol)

#This is only a BASIC installation (without desktop enviroments and fancy configurations)

#boring configuration of the system
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime

hwclock --systohc

sed -i '171s/.//' /etc/locale.gen

locale-gen

#Generating US locale , if u re not english than learn it (:
echo "LANG=en_US.UTF-8" >> /etc/locale.conf



#to search your keyboard use -> "localctl list-keymaps | grep your_key_map"

#Spanish keyboard
echo "KEYMAP=es" >> /etc/vconsole.conf

#Variable that stores your hostname
read -s -p 'Type the of the hostname: ' hostname_var

echo "$hostname_var" >> /etc/hostname

echo "127.0.0.1 localhost" >> /etc/hosts

echo "::1	localhost" >> /etc/hosts

echo "127.0.1.1 $hostname_var.localdomain $hostname_var" >> /etc/hosts

#Password for your root user
read -s -p 'Type the password for your root user: ' root_passwd

echo root:$root_passwd | chpasswd

#install the packages

pacman -S grub efibootmgr networkmanager pulseaudio dialog mtools dosfstools os-prober base base-devel firefox kitty neovim htop neofetch #sddm pfetch 

#NOTE: Put an command that installs my tilling window managers

#Choice: i3, qtile, xmonad , bspwm , dwm , specdwm

#NOTE: Put an script to install yay and nerd fonts

#NOTE: Put an command that downloads by dotfiles from github and copies all the configs to my .config  



#NOTE: Put an if statment that asks the user what drivers he wants to install nvidia , amd or none of them

#install nvidia drivers
#pacman -S --noconfirm nvidia nvidia-utils nvidia-settings

#install amd drivers

#pacman -S --noconfirm xf86-video-amdgpu


#grub installation
setterm --foreground magenta
#if you mounted the partition at /boot/efi , CHANGE THIS COMMAND TO -> "grub-install --target=x86_64-efi --efi-directory=/boot/efi --bootloader-id=GRUB"
grub-install --target=x86_64-efi --efi-directory=/boot --bootloader-id=GRUB

#generating grub-config
grub-mkconfig -o /boot/grub/grub.cfg

#enable services
systemctl enable NetworkManager
#systemctl enable sddm
#NOTE: Put an if statment to check if sddm is installed
#systemctl enable sddm
setterm --foreground white
#Name of the user
read -p 'Type your username ' user_name
useradd -m $user_name

#Password for the new user
read -s -p 'Type the password for your new user: ' user_passwd
echo $user_name:$user_passwd | chpasswd

#Adding root permissions for the new users
echo "$user_name ALL=(ALL) ALL" >> /etc/sudoers.d/$user_name

#Final message
setterm --foreground green
printf "\nYou are done mate , you can reboot\n"
setterm --foreground white
