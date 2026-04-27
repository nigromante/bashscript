#!/bin/bash

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod sys
    ldr_insmod dev
    ldr_insmod utils
}


run() {
    user=$1
    server=$2
    cmd="$3"

    ssh_Exec  "${user}@${server}" "${cmd}"
}


loader_manager
run $@

