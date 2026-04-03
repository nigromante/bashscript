#!/bin/bash



# These require command to get and are needed for the usage message,
# which is why they are the only defaults pulled out as a variable
# like this.
DEFAULT_SUITE="$( grep -s -m1 '^deb ' /etc/apt/sources.list | awk '{print $3}' )"
DEFAULT_DOMAIN="$( hostname )"
# In MiB.  How large should swap be? First 271MiB is used for system (boot)
# partitions and reserved space, so 753 takes us to the 1024MiB (1GiB)
# position on the disk (1(reserved) + 270(efi) + 753(swap) = 1024MiB = 1GiB)
DEFAULT_SWAP=753
# An be in any format recognised by qemu-img - note sizes (K, M, G, T) are KiB not KB.
DEFAULT_SIZE="5G"


usage() {
	cat - <<EOF
Usage: $0 [-hSDM] [-s suite] [-f file] [-z size] [-r passwd] [name]

-h:        Display this message and exit
-S:        Skip debootstrap initialising a blank image and go stright to
           mounting.  Requires an already setup image file as target.
-D:        Do debootstrap only and exit without chrooting and doing the
           stage 2 process.  As the debootstrap is the most time-consuming
           element, this can be helpful combined with -S during debugging and
           development.  The stage 2 script will still be written out.
-M:        Leave the NBD attached and chroot filesystems mounted at the end.
-s suite:  the Debian suite to build, defaults to $DEFAULT_SUITE (taken from
           first line matching /^deb / in /etc/apt/sources.list).
-f file:   filename for the image, defaults to <name>.qcow2
-z size:   Size of the image, in a format understood by the qemu-img command.
           Defaults to $DEFAULT_SIZE, first 1GiB is entirely consumed by boot and swap
           partitions.
-w size:   Size of the image's swap partition in MiB (set to 0 to disable),
           defaults to ${DEFAULT_SWAP}
-r var:    Use passwd in var environment variable as the encrypted root
           password in the built image (avoids exposing the password via the
           command-line, which any user on the system can see).
-d domain: Use domain as the new hosts domain, defaults to $DEFAULT_DOMAIN (
           taken from this host's 'hostname -d')
name:      hostname to configure the image to, defaults to debian-<suite>
EOF
}


proc_args() {
while getopts ":hSDMs:f:z:r:d:" opt;
do
	case $opt in
		h )
			usage
			exit 0
			;;
		\? )
			usage
			exit 0
			;;
		s )
			SUITE="$OPTARG"
			;;
		f )
			FILE="$OPTARG"
			;;
		z )
			SIZE="$OPTARG"
			;;
		r )
			ROOT_PASSWD="$( eval "echo \${$OPTARG}" )"
			;;
		d )
			DOMAIN_NAME="$OPTARG"
			;;
		S )
			SKIP_DEBOOTSTRAP="skip"
			;;
		D )
			SKIP_STAGE2="skip"
			;;
		M )
			SKIP_UNMOUNT="skip"
			;;
		: )
			echo "Error: option $OPTARG missing an argument" >&2
			exit 1
			;;
	esac
done
shift $((OPTIND - 1))

NAME="$1"

# Set defaults for anything not set
[[ -z $SUITE ]] && SUITE="$DEFAULT_SUITE"
[[ -z $NAME ]] && NAME="debian-$SUITE"
[[ -z $FILE ]] && FILE="$NAME.qcow2"
[[ -z $SIZE ]] && SIZE="$DEFAULT_SIZE"
[[ -z $DOMAIN_NAME ]] && DOMAIN_NAME="$DEFAULT_DOMAIN"
[[ -z $SWAP_SIZE ]] && SWAP_SIZE="$DEFAULT_SWAP"

[[ -z $ROOT_PASSWD ]] && echo "No root password given.  None will be set in the image."

# Other variables that might need to be changed or user-provided options in
# the future
NBD_DEV=/dev/nbd0 # NBD device for connecting image
# In MiB, how large should be EFI system partition be. According to Arch's
# wiki "the partition should be at least 260 MiB":
# https://wiki.archlinux.org/index.php/EFI_system_partition
EFI_SIZE=270


}

