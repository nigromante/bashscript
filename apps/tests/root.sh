#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    ldr_insmod framework/root
    ldr_insmod sys
    ldr_insmod choices
    ldr_insmod utils
}


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Module Loader"
    app_setDescription  "  Modules & Functions "
}

run() {
    ldr_mod_verbose
    ldr_mod_list
}

loader_manager
start


