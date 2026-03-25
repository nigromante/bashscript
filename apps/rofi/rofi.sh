#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad framework/user
    moduleLoad sys
    moduleLoad rofi
    moduleLoad utils
    moduleLoadLocal src
}


loader_manager
start
