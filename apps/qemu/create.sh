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


loader_manager
start $@

