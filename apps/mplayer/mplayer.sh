#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    ldr_insmod framework/user
    ldr_insmod sys
    ldr_insmod choices
    ldr_insmod utils
    ldr_insmod_local src
}


loader_manager
start
