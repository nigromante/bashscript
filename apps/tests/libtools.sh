#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    ldr_mod_verbose
    ldr_insmod sys
    ldr_insmod sys
    ldr_mod_disable choices
    ldr_insmod framework/user
    ldr_insmod choices
    ldr_insmod utils
}


begin() {

    moduleInfo

}


loader_manager

start

