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
     SSH / exec command
  --------------------------------

  usage:
      ezdbg  ssh/exec.sh user server command

  parameters:
      user 
      server 
      command

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
    cmd="$3"

    ssh_Exec  "${user}@${server}" "${cmd}"
}


loader_manager
run $@

