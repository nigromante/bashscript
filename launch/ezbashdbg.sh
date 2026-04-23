#!/bin/bash

INSTALL_PATH='/home/julian/work/bashscript'

LIBPATH="${INSTALL_PATH}/lib"
export LIBPATH="$LIBPATH"

APPS_PATH="${INSTALL_PATH}/apps"


chk=$( basename $1 )

[[ "$1" == "$chk" ]] && file="$1/$1.sh" ||  file="$1"

file="${APPS_PATH}/$file"

shift

eval bash "$file" "$@"

