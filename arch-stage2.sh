#!/usr/bin/env bash

echo "setup grub 2"
grub-install --target=i386-pc /dev/sda3
grub-mkconfig -o /boot/grub/grub.cfg

echo "set localtime"
ln -sf /usr/share/zoneinfo/America/Los_Angeles /etc/localtime

hwclock --systohc

echo "Uncomment en_US.UTF-8 UTF-8 and other needed localizations in /etc/locale.gen, and generate them with:"

#en_US.UTF-8 is the default, generate:
locale-gen

#Set the LANG variable in locale.conf(5) accordingly, for example:

#/etc/locale.conf
#LANG=en_US.UTF-8

#If you set the keyboard layout, make the changes persistent in vconsole.conf(5):

#/etc/vconsole.conf
#KEYMAP=de-latin1

echo "aggron" > /etc/hostname
echo "add hostname to /etc/hosts"
echo "127.0.0.1	localhost
::1		localhost
127.0.1.1	aggron.dondon.ninja	aggron" >> /etc/hosts

echo "configure network manually"
ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
ln -s '/usr/lib/systemd/system/dhcpcd@.service' '/etc/systemd/system/multi-user.target.wants/dhcpcd@eth0.service'
systemctl enable dhcpcd.service
sed -i 's/#UseDNS yes/UseDNS yes/' /etc/ssh/sshd_config
systemctl enable sshd.service

echo "make ramfs"
mkinitcpio -p linux

echo "set root password"
passwd

echo "make users"

#Vagrant User w/ password-less sudo
useradd --password ${PASSWORD} --comment 'Vagrant User' --create-home --user-group vagrant
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_vagrant
chmod 0440 /etc/sudoers.d/10_vagrant
install --directory --owner=vagrant --group=vagrant --mode=0700 /home/vagrant/.ssh
curl --output /home/vagrant/.ssh/authorized_keys --location https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
chmod 0600 /home/vagrant/.ssh/authorized_keys

pacman -Sy zerotier-one
systemctl enable zerotier-one.service
