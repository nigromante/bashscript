#!/bin/bash

INSTALL_PATH='/home/julian/work/bashscript'

LIBPATH="${INSTALL_PATH}/lib"
export LIBPATH="$LIBPATH"

APPS_PATH="${INSTALL_PATH}/apps"


file="${APPS_PATH}/$1"

shift

eval bash "$file" "$@"


