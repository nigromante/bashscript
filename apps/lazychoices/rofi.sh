#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {

    moduleVerbose

    moduleLoad framework/user
    moduleLoad sys
    moduleLoad choices 
    moduleLoad utils
    moduleLoadLocal src
}


loader_manager
start
