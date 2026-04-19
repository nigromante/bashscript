#!/bin/bash

source ${LIBPATH}/_loader.sh

choices_test_loader_manager() {
    ldr_insmod choices 
    ldr_insmod sys
    ldr_insmod_local src
}

choices_test_loader_manager

choices_test_entry  $@
