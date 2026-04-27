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

    ssh_Cert "${user}@${server}"
}


loader_manager
run $@

