#!/bin/bash

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod framework/root
    ldr_insmod sys
    ldr_insmod dev
    ldr_insmod kernel
}


begin() {
    app_setTitle        "Kernel Compiler"

    peval_theme_vision
    peval_mode_debug
}


run() {
  make_main $@
}

loader_manager
start $@

