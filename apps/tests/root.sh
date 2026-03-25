#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad framework/root
    moduleLoad sys
    moduleLoad menu
    moduleLoad utils
}


init() {
    setAuthor       "JULIAN VIDAL A"
    setTitle        "Module Loader"
    setDescription  "  Modules & Functions "
}

run() {
    moduleVerbose
    moduleList
}

loader_manager
start


