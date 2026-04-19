#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    ldr_mod_verbose
    ldr_insmod sys 
}

loader_manager


