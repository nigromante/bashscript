#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad sys 
    moduleLoad dev 
}

loader_manager


peval_theme_vision
peval ls -a

peval_theme_none
peval_mode_result
rr=$( peval ls )
echo "rr : [$rr]"
echo

peval_theme_vision
peval_mode_command
peval ls -al | grep cmd


