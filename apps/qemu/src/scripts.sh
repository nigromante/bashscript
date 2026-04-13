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
tzdata tzdata/Areas select America
tzdata tzdata/Zones/Europe select Santiago
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
deb http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm main contrib non-free non-free-firmware
deb http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian-security/ bookworm-security main contrib non-free non-free-firmware
deb http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
deb-src http://deb.debian.org/debian bookworm-updates main contrib non-free non-free-firmware
S2EOF

apt -qq -y update

echo "--------------------------------------------"

echo "Configuring locales and keyboard"
debconf-set-selections <<S2EOF
locales locales/locales_to_be_generated multiselect es_CL.UTF-8 UTF-8
locales locales/default_environment_locale select es_CL.UTF-8
keyboard-configuration keyboard-configuration/layoutcode string latam
keyboard-configuration keyboard-configuration/variant select Latin American 
keyboard-configuration keyboard-configuration/model select Generic 105-key PC (intl.)
S2EOF
# Stop anything overriding debconf's settings
rm -f /etc/default/locale /etc/locale.gen /etc/default/keyboard
apt -qq -y install locales console-setup

echo "--------------------------------------------"

echo "Installing kernel"
apt -qq -y install linux-image-amd64

echo "--------------------------------------------"

echo "Installing bootloader"
apt -qq -y install grub-efi-amd64
grub-install  /dev/nbd0
update-grub

echo "Copying fallback bootloader"
mkdir /boot/efi/EFI/BOOT
cp /boot/efi/EFI/debian/fbx64.efi /boot/efi/EFI/BOOT/bootx64.efi

echo "--------------------------------------------"


if [[ -n '$ROOT_PASSWD' ]]
then
	echo "Setting root password"
	echo "root:$ROOT_PASSWD" 
	echo "root:$ROOT_PASSWD" | chpasswd 
	echo "--------------------------------------------"
fi

echo "Tidying..."
apt clean

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
	    # rm /mnt/root/stage-2-setup.bash
    else
	    echo "Skipping stage 2, script has been writtn to /mnt/root/stage-2-setup.bash"
    fi
}
