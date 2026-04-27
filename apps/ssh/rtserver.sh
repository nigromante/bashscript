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
     SSH / Remote Tunnel Server 
  --------------------------------

  usage:
      ezdbg  ssh/rtserver.sh externConn externPort

  parameters:
      externConn : user@sshdhost 
      externPort : shared port on external sshd host

  remarks:
      this 

EOF
}


run() {
    if [[ $# -lt 2 ]]; then
      help
      return
    fi

    externConn="$1"
    externPort="$2"

    ssh_RTunnelInside  $externConn  $externPort
}



loader_manager
run $@

