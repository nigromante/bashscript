#!/bin/bash


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Debian VM debootstrap"
    app_setDescription  " --- MOUNT IMAGE --- "

    proc_args $@
}


run() {
    resume_values
    set -e

    peval_theme_vision
    peval_mode_debug

    Stage1
    Stage2

    figlet "Finish"
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


Stage1() {
  vio_setColor $GREEN
  figlet "Stage 1"
  nbd_mount
  hdd_read_UUID
  chroot_mount
  chroot_mount_system
}


Stage2() {
  vio_setColor $RED
  figlet "Stage 3"
  chroot_umount
  nbd_umount
}

