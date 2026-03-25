#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleVerbose

    moduleLoad "tools"
    moduleLoad "tools2"

    moduleList
}

main() {
    pruebaFn
    prueba2Fn
    prueba2Fn2
}

clear
loader_manager
main
echo "--- FIN ---"
