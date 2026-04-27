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
     SSH / Local Tunnel Client 
  --------------------------------

  usage:
      ezdbg  ssh/ltclient.sh user port

  parameters:

  remarks:
      this 

EOF
}


run() {
    if [[ $# -lt 2 ]]; then
      help
      return
    fi

    user=$1
    port=$2

    peval ssh_LTunnelConn $user $port
}



loader_manager
run $@

