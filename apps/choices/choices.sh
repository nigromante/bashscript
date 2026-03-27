#!/bin/bash

source ${LIBPATH}/_loader.sh

choices_test_loader_manager() {
    moduleLoad choices 
    moduleLoad sys
    moduleLoadLocal src
}

choices_test_loader_manager

choices_test_entry  $@
