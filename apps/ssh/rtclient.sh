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
     SSH / Remote Tunnel Client 
  --------------------------------

  usage:
      ezdbg  ssh/rtclient.sh user port

  parameters:
      user  : user 
      port  : port

  remarks:
      this client allows to connect

EOF
}

run() {
    if [[ $# -lt 2 ]]; then
      help
      return
    fi

    user="$1"
    port="$2"

    ssh_RTunnelOutside $user $port
}



loader_manager
run $@

