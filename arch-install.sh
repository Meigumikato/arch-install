#! /usr/bin/env bash

read -n1 -rp "Are you sure connect to internet? (Y\n)" answer

if [[ $answer -ne "Y" ]]; then

      echo "please connect to internet"
      exit 1
fi

echo "Please partition the disk manually"

read -n1 -rp "please input your plan to partition device" device

device_status=$(fdisk -l | grep -c ${device})

if [[ $device_status -lt 1 ]]; then
      echo "please input right device name"
      exit 1
fi

echo "default: /boot 500M  swap 16G  /root last"

# mkfs.ext4  mkfs.fat -F32  mkswap  swapon

fdisk ${device}


pacstrap /mnt base base-devel linux linux-firmware
genfstab -U /mnt >> /mnt/etc/fstab
# check /mnt/etc/fstab 
# change to root
arch-chroot /mnt
# set time zone
ln -sf /usr/share/zoneinfo/Asia/Shanghai /etc/localtime
# run hwclock gen /etc/adjustime
hwclock --systohc

sed -i "s/#en_US.UTF-8 UTF-8/en_US.UTF-8 UTF-8/g"
sed -i "s/#zh_CN.UTF-8 UTF-8/zh_CN.UTF-8 UTF-8/g"
sed -i "s/#zh_HK.UTF-8 UTF-8/zh_HK.UTF-8 UTF-8/g"
locale-gen

echo "LANG=en_US.UTF-8" > /etc/locale.conf

read -n1 -rp "Please input you network hostname" host

echo "$host" > /etc/hostname

echo "127.0.0.1 ${host} \
      ::1       ${host} \
      127.0.1.1 ${host}.localdomain ${host}" >> /etc/hosts

echo "please input your root user password"
passwd 

# grub  boot
mkdir -p /mnt/boot
mount /dev/sdaW /mnt/boot/EFI

grub-install --target=x86_64-efi --efi-directory=esp --bootloader-id=GRUB
grub-mkconfig -o /boot/grub/grub.cfg

exit
umount -R /mnt
reboot











