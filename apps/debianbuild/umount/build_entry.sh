#!/bin/bash


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Debian VM debootstrap"
    app_setDescription  " --- UMOUNT IMAGE --- "

    proc_args $@
}


run() {
    set -e

    peval_theme_vision
    peval_mode_debug

    Stage1

    figlet "Finish"
}

Stage1() {
  vio_setColor $RED
  figlet "Stage 1"
  nbd_check_support
  chroot_umount
  qemu_nbd_umount
}

