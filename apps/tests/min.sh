#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleVerbose
    moduleLoad sys 
}

loader_manager


