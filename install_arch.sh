#!/bin/bash
#Autor: WolverineBeast1

# ____            _       _   
#/ ___|  ___ _ __(_)_ __ | |_ 
#\___ \ / __| '__| | '_ \| __|
# ___) | (__| |  | | |_) | |_ 
#|____/ \___|_|  |_| .__/ \__|
#                  |_|     

#Please read the script carrefully and with calm

#Semi automated arch install script to make the installation easier (:


#Symbolic link of the timezone
ln -sf /usr/share/zoneinfo/Europe/Madrid /etc/localtime
#Sets up the clock
timedatectl set-ntp true
#Syncs the clock
hwclock --systohc

#Uncomments the line 171 which is en_US.UTF-8 
sed -i '171s/.//' /etc/locale.gen

#Generates the locale 
locale-gen

#Redirects the the output to /etc/locale.conf 
echo "LANG=en_US.UTF-8" >> /etc/locale.conf



#to search your keyboard use -> "localctl list-keymaps | grep your_key_map"

#Spanish keyboard
echo "KEYMAP=es" >> /etc/vconsole.conf
#Us keyboard
# echo "KEYMAP=us" >> /etc/vconsole.conf

#Variable that stores your hostname
read -p -r 'Type the of the hostname: ' hostname_var
read -s -r 'Type the of the hostname: ' hostname_var
echo "$hostname_var" >> /etc/hostname

#Redirecting the outputs to the config files of hosts

echo "127.0.0.1 localhost" >> /etc/hosts

echo "::1	localhost" >> /etc/hosts

echo "127.0.1.1 $hostname_var.localdomain $hostname_var" >> /etc/hosts

#Password for your root user
read -s -p 'Type the password for your root user: ' root_passwd

echo root:$root_passwd | chpasswd

#install the packages 
pacman -S grub efibootmgr networkmanager pulseaudio dialog mtools dosfstools os-prober base base-devel firefox kitty neovim htop neofetch sddm lsd bat i3 i3lock polybar xclip xscreensaver ttf-jetbrains-mono tldr lxappearance unzip zip tar maim code zoxide rofi rofi-emoji nemo nitrogen

#NOTE: If you dont have any card you don't need to install nothing

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
systemctl enable sddm
setterm --foreground white
#Name of the user
read -p 'Type your username ' user_name
useradd -m $user_name

#Password for the new user
read -s -p 'Type the password for your new user: ' user_passwd
echo "$user_name:$user_passwd" | chpasswd

#Adding root permissions for the new users
echo "$user_name ALL=(ALL) ALL" >> /etc/sudoers.d/$user_name

#Final message
setterm --foreground green
printf "\nYou are done mate you can reboot\n"
setterm --foreground white
