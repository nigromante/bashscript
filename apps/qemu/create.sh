#!/bin/bash

## Usage:
#       export root_pass=secret
#       sudo --preserve-env=root_pass ../../launch/run.sh ./create.sh -r root_pass -s bookworm
#

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod framework/root
    ldr_insmod sys
    ldr_insmod dev
    ldr_insmod utils
    ldr_insmod_local src
}



DEFAULT_SUITE="$( grep -s -m1 '^deb ' /etc/apt/sources.list | awk '{print $3}' )"
DEFAULT_DOMAIN="$( hostname )"
DEFAULT_SWAP=753
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
	-z size:   Size of the image.
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
exit 0
}


proc_args() {
	while getopts ":hSDMs:f:z:r:d:w:" opt;
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
      w )
        WORKDIR="$OPTARG"
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

	[[ -z $FULLNAME ]] && FULLNAME="${NAME}_${DOMAIN_NAME}"

	[[ -z $WORKDIR ]] && WORKDIR="../../tmp"
}


resume_values() {
    echo "size                 : $SIZE" 
    echo "hostname             : $NAME"
    echo "file                 : $FILE" 
    echo "suite                : $SUITE"
    echo "host name            : $DOMAIN_NAME"
    echo "swap size            : $SWAP_SIZE"
    echo "root password        : $ROOT_PASSWD"
    echo "debootstrap          : $SKIP_DEBOOTSTRAP"
    echo "run install scripts  : $SKIP_STAGE2"
    echo "umount               : $SKIP_UNMOUNT"
}


Stage0() {
  vio_setColor $YELLOW
  figlet "Stage 0"
  qemu_create_image
  nbd_check_support
  qemu_nbd_mount
  hdd_fdisk
  hdd_format
  qemu_nbd_umount
}


Stage1() {
  vio_setColor $GREEN
  figlet "Stage 1"
  qemu_nbd_mount
  hdd_read_UUID
  chroot_mount
  debootrap_run
  chroot_mount_system
}


Stage2() {
  vio_setColor $PURPLE
  figlet "Stage 2"
  scripts_create
  scripts_run
}


Stage3() {
  vio_setColor $RED
  figlet "Stage 3"
  chroot_umount
  qemu_nbd_umount
}


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Debian VM debootstrap"
    app_setDescription  " --- BUILD DEBIAN IMAGE --- "

    proc_args $@

    peval_theme_vision
    peval_mode_debug
}


run() {
    resume_values

    Stage0
    Stage1
    Stage2
    Stage3
}


loader_manager
start $@

