#!/usr/bin/env bash


scripts_create() {

echo "Preparing stage 2"
cat > /mnt/root/stage-2-setup.bash <<EOF
#!/bin/bash

set -e # Abort on error

export DEBIAN_FRONTEND=noninteractive

echo "Configuring fstab"
cat > /etc/fstab <<S2EOF
# /etc/fstab: static file system information.
#
# Use 'blkid' to print the universally unique identifier for a
# device; this may be used with UUID= as a more robust way to name devices
# that works even if disks are added and removed. See fstab(5).
#
# <file system> <mount point>   <type>  <options>       <dump>  <pass>
$( [[ -z $NO_SWAP ]] && echo "$SWAP_UUID none swap sw  0       0" )
$ROOT_UUID / ext4 errors=remount-ro 0 1
$EFI_UUID /boot/efi vfat defaults 0 1
S2EOF
cat /etc/fstab

echo "...mounting"
[[ -d /boot/efi ]] || mkdir /boot/efi
mount -a

echo "--------------------------------------------"

echo "Setting timezone"
debconf-set-selections <<S2EOF
tzdata tzdata/Areas select Europe
tzdata tzdata/Zones/Europe select London
S2EOF
# This is necessary as tzdata will assume these are manually set and override the debconf values with their settings
rm -f /etc/localtime /etc/timezone
dpkg-reconfigure -f noninteractive tzdata

echo "--------------------------------------------"

echo "Configuring networking"
echo "...lo"
cat - >>/etc/network/interaces <<S2EOF

auto lo
iface lo inet loopback
S2EOF

echo "...enp1s0"
cat - >/etc/network/interfaces.d/enp1s0 <<S2EOF
allow-hotplug enp1s0
iface enp1s0 inet dhcp
S2EOF

echo "Configuring hostname"
echo "$NAME" > /etc/hostname

echo "Setting up /etc/hosts"
cat - >/etc/hosts <<S2EOF
127.0.0.1       localhost
127.0.1.1       $NAME.$DOMAIN_NAME $NAME

# The following lines are desirable for IPv6 capable hosts
::1     localhost ip6-localhost ip6-loopback
ff02::1 ip6-allnodes
ff02::2 ip6-allrouters
S2EOF

echo "--------------------------------------------"

echo "Configuring apt sources"

cat - >/etc/apt/sources.list <<S2EOF
deb http://ftp.uk.debian.org/debian/ buster main
deb-src http://ftp.uk.debian.org/debian/ buster main

deb http://security.debian.org/debian-security buster/updates main
deb-src http://security.debian.org/debian-security buster/updates main

# buster-updates, previously known as 'volatile'
deb http://ftp.uk.debian.org/debian/ buster-updates main
deb-src http://ftp.uk.debian.org/debian/ buster-updates main
S2EOF

apt-get -qq -y update

echo "--------------------------------------------"

echo "Configuring locales and keyboard"
debconf-set-selections <<S2EOF
locales locales/locales_to_be_generated multiselect en_GB.UTF-8 UTF-8
locales locales/default_environment_locale select en_GB.UTF-8
keyboard-configuration keyboard-configuration/layoutcode string gb
keyboard-configuration keyboard-configuration/variant select English (UK)
keyboard-configuration keyboard-configuration/model select Generic 105-key PC (intl.)
S2EOF
# Stop anything overriding debconf's settings
rm -f /etc/default/locale /etc/locale.gen /etc/default/keyboard
apt-get -qq -y install locales console-setup

echo "--------------------------------------------"

echo "Installing kernel"
apt-get -qq -y install linux-image-amd64

echo "--------------------------------------------"

echo "Installing bootloader"
apt-get -qq -y install grub-efi-amd64
# Add console=ttyS0 so we get early boot messages on the serial console.
sed -i -e 's/^\\(GRUB_CMDLINE_LINUX="[^"]*\\)"$/\\1 console=ttyS0"/' /etc/default/grub
cat - >>/etc/default/grub <<S2EOF
GRUB_TERMINAL="serial"
GRUB_SERIAL_COMMAND="serial --unit=0 --speed=9600 --stop=1"
S2EOF
grub-install --target=x86_64-efi
update-grub

echo "Copying fallback bootloader"
mkdir /boot/efi/EFI/BOOT
cp /boot/efi/EFI/debian/fbx64.efi /boot/efi/EFI/BOOT/bootx64.efi

echo "--------------------------------------------"

echo "Enabling serial console"
systemctl enable serial-getty@ttyS0.service

echo "--------------------------------------------"

if [[ -n '$ROOT_PASSWD' ]]
then
	echo "Setting root password"
	echo 'root:$ROOT_PASSWD' | chpasswd -e
	echo "--------------------------------------------"
fi

echo "Tidying..."
apt-get clean

echo "=== STAGE 2 SUCCESSFULLY REACHED THE END ==="
EOF


}

scripts_run() {
    # Only do stage 2 if not skipping it
    if [[ -z $SKIP_STAGE2 ]]
    then
	    echo "Running stage 2 script in chroot"
	    LANG=C.UTF-8 chroot /mnt /bin/bash /root/stage-2-setup.bash

	    echo "Removing stage 2 script"
	    rm /mnt/root/stage-2-setup.bash
    else
	    echo "Skipping stage 2, script has been writtn to /mnt/root/stage-2-setup.bash"
    fi
}
