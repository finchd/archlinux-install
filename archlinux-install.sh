#!/usr/bin/env bash

echo "Run after making partitions and mounting them in /mnt sub-tree"

#update clock
echo "Updating local clock by ntp"
timedatectl set-ntp true

#make sure the arch package maintainers GPG Keys are up to date:
echo "Updating installer's set of packager's trusted GPG Keys"
pacman-key --refresh-keys

pacstrap /mnt base base-devel openssh qemu libvirt omvf virt-manager
#python2 for ansible 
#openssh or #openssh-server 
# qemu, libvirt, ovmf, and virt-manager (gui?) for VFIO

#Copy second bootstrapping script for post-chroot
echo "Copying /tmp/arch-stage2.sh to /mnt/opt/arch-stage2.sh"
cp /tmp/arch-stage2.sh /mnt/opt/arch-stage2.sh
chmod 777 /mnt/opt/arch-stage2.sh

echo "Done! Now arch-chroot /mnt and start stage2"
exit 0