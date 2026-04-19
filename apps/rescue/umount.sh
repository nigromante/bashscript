#!/bin/bash

## Usage:
#
#       sudo ../../launch/run.sh ./umount.sh
#

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod framework/root
    ldr_insmod sys
    ldr_insmod dev
    ldr_insmod_local src
}


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Linux Rescue"
    app_setDescription  " --- UMOUNT IMAGE --- "

    peval_theme_vision
    peval_mode_debug
}


run() {
    
    umount_device $@
    
}


loader_manager
start $@
