#!/bin/bash

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod dev
    ldr_insmod sys
    ldr_insmod utils
}


run() {
    user=$1
    server=$2
    peval ssh_Cert "${user}@${server}"
}



loader_manager

peval_theme_vision
peval_mode_debug

run $@

