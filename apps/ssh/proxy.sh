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
     SSH / proxy
  --------------------------------

  usage:
      ezdbg  ssh/proxy.sh user server port

  parameters:
      user 
      server 
      port  

  remarks:
      this 

EOF
}


run() {
    if [[ $# -lt 3 ]]; then
      help
      return
    fi

    user=$1
    server=$2
    port=$3

    ssh_DProxy "${user}@${server}" ${port}
}


loader_manager
run $@

