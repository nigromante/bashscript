#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad sys 
}

moduleVerbose
loader_manager


