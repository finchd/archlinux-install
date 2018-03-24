#!/usr/bin/env bash

echo "Run after making partitions and mounting them in /mnt sub-tree"

#update clock
echo "Updating local clock by ntp"
timedatectl set-ntp true

#make sure the arch package maintainers GPG Keys are up to date:
echo "Updating installer's set of packager's trusted GPG Keys"
pacman-key --refresh-keys

pacstrap /mnt base base-devel grub os-prober lsb-release openssh libvirt vim
#python2 for ansible 
#grub 2 / os-prober to boot with, os-prober used by default in /etc/grub.d/30_os-prober
#lsb-release improves detection from other OSes, makes /etc/lsb-release
#openssh or #openssh-server 
# libvirt, (qemu, ovmf, and virt-manager gui) for VFIO
#vim and vim-plugins group?

#make fstab
echo "Making fstab"
genfstab -U /mnt >> /mnt/etc/fstab

#Copy second bootstrapping script for post-chroot
echo "Copying /tmp/arch-stage2.sh to /mnt/opt/arch-stage2.sh"
cp /tmp/arch-stage2.sh /mnt/opt/arch-stage2.sh
chmod 777 /mnt/opt/arch-stage2.sh

echo "Done! Now arch-chroot /mnt and start stage2"
exit 0
