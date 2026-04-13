#!/bin/bash

## Usage:
#
#       sudo ../../launch/run.sh ./umount.sh  -f ../../tmp/debian.qcow2
#

source ${LIBPATH}/_loader.sh


loader_manager() {
    moduleLoad framework/root
    moduleLoad sys
    moduleLoad dev
    moduleLoad utils
    moduleLoadLocal src
}


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Debian VM debootstrap"
    app_setDescription  " --- UMOUNT IMAGE --- "

    proc_args $@

    peval_theme_vision
    peval_mode_debug
}


run() {
    nbd_check_support
    chroot_umount
    qemu_nbd_umount
}


loader_manager
start $@

