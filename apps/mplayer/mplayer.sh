#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad framework/user
    moduleLoad sys
    moduleLoad choices
    moduleLoad utils
    moduleLoadLocal src
}


loader_manager
start
