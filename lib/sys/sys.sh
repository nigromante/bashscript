#!/bin/bash


sys_getUserName() {
    USERNAME=$(whoami)
    echo $USERNAME
}




sys_call() {
    bash "$1.sh" "$2" "$3" 
    vio_resetColor
}


sys_checkRoot() {
  if [ $EUID -ne 0 ]
  then
    vio_error "${BRx2}Esta aplicación corre con privilegios de root ... ${BRx2}"
	  exit 1	
  fi
}


sys_checkUser() {
  if [ $EUID == 0 ]
  then
    vio_error "${BRx2}Esta aplicación NO corre con privilegios de root ${BRx2}"
	  exit 1	
  fi
}

