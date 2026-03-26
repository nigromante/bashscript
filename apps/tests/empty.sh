#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad sys
    moduleLoad framework/user
}

initdd(){ 
  echo -n "" 
}


moduleVerbose
loader_manager
start


