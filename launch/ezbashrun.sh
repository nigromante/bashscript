#!/bin/bash

INSTALL_PATH='/home/julian/.local/share'

LIBPATH="${INSTALL_PATH}/lib/ezbash"
export LIBPATH="$LIBPATH"

APPS_PATH="${INSTALL_PATH}/bin/apps"


file="${APPS_PATH}/$1"

shift

eval bash "$file" "$@"


