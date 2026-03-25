#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleVerbose
    moduleLoad sys
    moduleLoad menu
    moduleLoad user
    moduleLoad utils
    moduleList
}

main() {
    moduleListFunctions
    echo "--- FIN ---"
}


clear
loader_manager
main
