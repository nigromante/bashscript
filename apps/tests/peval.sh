#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad sys 
}

loader_manager


peval_theme_vision
peval "ls -al"

