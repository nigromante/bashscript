#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleVerbose
    moduleLoad "sys"
    moduleList
}

main() {
    moduleListFunctions
    echo "--- FIN ---"
}


clear
loader_manager
main
