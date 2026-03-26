#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad sys
    moduleLoad framework/user
}


loader_manager
start


