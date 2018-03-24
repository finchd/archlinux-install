#!/usr/bin/env bash

#set localtime
ln -sf /usr/share/zoneinfo/Region/City /etc/localtime

hwclock --systohc

echo "Uncomment en_US.UTF-8 UTF-8 and other needed localizations in /etc/locale.gen, and generate them with:"

# locale-gen

#Set the LANG variable in locale.conf(5) accordingly, for example:

#/etc/locale.conf

LANG=en_US.UTF-8

#If you set the keyboard layout, make the changes persistent in vconsole.conf(5):

#/etc/vconsole.conf

KEYMAP=de-latin1

echo "aggron" > /etc/hostname

echo "configure network manually"
/usr/bin/ln -s /dev/null /etc/udev/rules.d/80-net-setup-link.rules
/usr/bin/ln -s '/usr/lib/systemd/system/dhcpcd@.service' '/etc/systemd/system/multi-user.target.wants/dhcpcd@eth0.service'
/usr/bin/sed -i 's/#UseDNS yes/UseDNS yes/' /etc/ssh/sshd_config
/usr/bin/systemctl enable sshd.service
systemctl start sshd.service

echo "make ramfs"
mkinitcpio -p linux

echo "set root password"
passwd

echo "make users"

/usr/bin/useradd --password ${PASSWORD} --comment 'Vagrant User' --create-home --user-group vagrant
echo 'Defaults env_keep += "SSH_AUTH_SOCK"' > /etc/sudoers.d/10_vagrant
echo 'vagrant ALL=(ALL) NOPASSWD: ALL' >> /etc/sudoers.d/10_vagrant
/usr/bin/chmod 0440 /etc/sudoers.d/10_vagrant
/usr/bin/install --directory --owner=vagrant --group=vagrant --mode=0700 /home/vagrant/.ssh
/usr/bin/curl --output /home/vagrant/.ssh/authorized_keys --location https://raw.github.com/mitchellh/vagrant/master/keys/vagrant.pub
/usr/bin/chown vagrant:vagrant /home/vagrant/.ssh/authorized_keys
/usr/bin/chmod 0600 /home/vagrant/.ssh/authorized_keys

pacman -Sy zerotier-one
systemctl start zerotier-one.service
systemctl enable zerotier-one.service
zerotier-cli join 6ab565387ad1717b