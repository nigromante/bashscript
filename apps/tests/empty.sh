#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    ldr_insmod sys
    ldr_insmod framework/user
}


loader_manager
start


