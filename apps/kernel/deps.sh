#!/bin/bash

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod framework/root
    ldr_insmod sys
    ldr_insmod dev
    ldr_insmod kernel
}


begin() {
    app_setTitle        "Kernel Dependencies"

    peval_theme_vision
    peval_mode_debug
}


run() {
    sudo apt update
    
    sudo apt install \
      build-essential \
      libncurses-dev \
      flex \
      bison \
      libssl-dev \
      libelf-dev \
      libdw-dev \
      debhelper-compat
}

loader_manager
start $@

