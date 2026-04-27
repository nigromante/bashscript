#!/bin/bash

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod sys
    ldr_insmod dev
    ldr_insmod utils
}


help() {
  cat << EOF
  --------------------------------
     SSH / Local Tunnel Server 
  --------------------------------

  usage:
      ezdbg  ssh/ltserver.sh  port target user server 

  parameters:

  remarks:
      this 

EOF
}


run() {
    if [[ $# -lt 4 ]]; then
      help
      return
    fi

    port=$1
    target=$2
    user=$3
    server=$4

    peval ssh_LTunnel ${port} ${target}:22  "${user}@${server}"
}



loader_manager
run $@

