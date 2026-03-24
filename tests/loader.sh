#!/bin/bash


source ${LIBPATH}/_loader.sh

loadModule "tools"
loadModule "tools2"

main() {
    pruebaFn
    prueba2Fn
    prueba2Fn2
}

main
echo "--- FIN ---"
