#!/bin/bash

## Usage:
#
#       sudo ../../launch/run.sh ./mount.sh  -f ../../tmp/debian.qcow2
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
    app_setDescription  " --- MOUNT IMAGE --- "

    proc_args $@

    peval_theme_vision
    peval_mode_debug
}


run() {
    nbd_check_support
    qemu_nbd_mount
    hdd_read_UUID
    chroot_mount
    chroot_mount_system
}


loader_manager
start $@
