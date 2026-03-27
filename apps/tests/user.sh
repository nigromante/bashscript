#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad framework/user
    moduleLoad sys
    moduleLoad choices
    moduleLoad utils
}


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Module Loader"
    app_setDescription  "  Modules & Functions "
}

run() {
    moduleVerbose
    moduleList
}

loader_manager
start


