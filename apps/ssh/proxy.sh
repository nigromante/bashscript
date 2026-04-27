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
    port=$3

    peval ssh_DProxy "${user}@${server}" ${port}
}



loader_manager
run $@

