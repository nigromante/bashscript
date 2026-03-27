#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad choices 
    moduleLoad sys
    moduleLoadLocal src
}

loader_manager
# moduleVerbose
choices_entry  $@
