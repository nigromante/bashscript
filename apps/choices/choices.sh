#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad menu
    moduleLoad sys
    moduleLoadLocal src
}

loader_manager
choices_entry  $@
