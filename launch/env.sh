#!/bin/bash

scriptdir() {
    local SCRIPTPATH=$(realpath "$0")
    SCRIPTDIR=$(dirname "$SCRIPTPATH")
    echo "$SCRIPTDIR"
}

LIBPATH="$( scriptdir )/../lib"
export LIBPATH="$LIBPATH"

echo $LIBPATH


