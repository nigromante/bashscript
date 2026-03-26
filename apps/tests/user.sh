#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad framework/user
    moduleLoad sys
    moduleLoad choices
    moduleLoad utils
}


begin() {
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


