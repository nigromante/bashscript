#!/bin/bash


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Debian VM debootstrap"
    app_setDescription  " --- BUILD DEBIAN IMAGE --- "

    proc_args $@
}


run() {
    resume_values
    set -e

    Stage0
    Stage1
    Stage2
    Stage3

    echo "Finish"
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
  hdd_create_image
  nbd_check_support
  nbd_mount
  hdd_fdisk
  hdd_format
}


Stage1() {
  vio_setColor $GREEN
  hdd_read_UUID
  chroot_mount
  debootrap_run
  chroot_mount_system
}


Stage2() {
  vio_setColor $PURPLE
  scripts_create
  # scripts_run
}


Stage3() {
  vio_setColor $RED
  chroot_umount
  nbd_umount
}

