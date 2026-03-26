#!/bin/bash


getUserName() {
    USERNAME=$(whoami)
    echo $USERNAME
}


getCurrentWorkDir() {
    PWD=$(pwd)
    echo $PWD
}


call() {
    bash "$1.sh" "$2" "$3" 
    resetColor
}

check_root() {
  if [ $EUID -ne 0 ]
  then
    print "${BRx2}${ERROR}Esta aplicación corre con privilegios de root ... ${BRx2}"
	  exit 1	
  fi
}

check_user() {
  if [ $EUID == 0 ]
  then
    print "${BRx2}${ERROR}Esta aplicación NO corre con privilegios de root ${BRx2}"
	  exit 1	
  fi
}

