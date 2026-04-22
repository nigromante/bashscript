#!/bin/bash

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod framework/root
    ldr_insmod sys
    ldr_insmod dev
    ldr_insmod kernel
}


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Kernel"
    app_setDescription  " --- BUILD KERNEL --- "

    peval_theme_vision
    peval_mode_debug
}


run() {
    make_env $1
    make_all
}



loader_manager
start $@

