#!/bin/bash

INSTALL_PATH='/home/julian/.local/share'

LIBPATH="${INSTALL_PATH}/lib/ezbash"
export LIBPATH="$LIBPATH"

APPS_PATH="${INSTALL_PATH}/bin/apps"


chk=$( basename $1 )

[[ "$1" == "$chk" ]] && file="$1/$1.sh" ||  file="$1"

file="${APPS_PATH}/$file"

shift

eval bash "$file" "$@"

