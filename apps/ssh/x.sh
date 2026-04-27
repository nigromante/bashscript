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
     SSH / x
  --------------------------------

  usage:
      ezdbg  ssh/x.sh user server

  parameters:
      user 
      server 

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
    server=$2

    ssh_X  "${user}@${server}"
}


loader_manager
run $@

