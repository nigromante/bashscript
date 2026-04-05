#!/bin/bash

## Usage:
#
#       sudo ../../launch/run.sh ./deb-run.sh  -f ../../tmp/debian.qcow2
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
    app_setDescription  " --- RUN DEBIAN IMAGE --- "

    proc_args $@

    peval_theme_vision
    peval_mode_debug
}


run() {
    qemu_run
}


loader_manager
start $@

