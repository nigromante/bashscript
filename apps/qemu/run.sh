#!/bin/bash

## Usage:
#
#       sudo ../../launch/run.sh ./run.sh  -f ../../tmp/debian.qcow2
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
    app_setDescription  " --- RUN DEBIAN IMAGE --- "

    proc_args $@

    peval_theme_vision
    peval_mode_debug
}


run() {
    resume_values
    qemu_run
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
    echo "fullname             : $FULLNAME"
}

loader_manager
start $@

