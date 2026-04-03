#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad framework/root
    moduleLoad sys
    moduleLoad utils
    moduleLoadLocal src
}

## Usage:
#       export root_pass=secret
#       sudo --preserve-env=root_pass ../../launch/run.sh ./deb-image.sh -r root_pass -s bookworm
#


loader_manager
start $@
