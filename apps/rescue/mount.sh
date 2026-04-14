#!/bin/bash

## Usage:
#
#       sudo ../../launch/run.sh ./mount.sh
#

source ${LIBPATH}/_loader.sh


loader_manager() {
    moduleLoad framework/root
    moduleLoad sys
    moduleLoad dev
    moduleLoadLocal src
}


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Linux Rescue"
    app_setDescription  " --- MOUNT IMAGE --- "

    peval_theme_vision
    peval_mode_debug
}


run() {
    
    mount_device $@

}


loader_manager
start $@
