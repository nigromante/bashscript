#!/bin/bash

#  -----------------------------------------------------------------------------
# when need launch a app with root privileges
#
# sudo dont recognizes env variables but $LIBPATH is required to locate lib sources.
#
# this script simplifies it:
# example:
#     from apps folder
#         sudo ../launch/run.sh ./tests/libtools.sh arg1 arg2
#
#     from tests folder
#         sudo ../../launch/run.sh ./libtools.sh arg1 arg2
#  -----------------------------------------------------------------------------

scriptdir() {
    local SCRIPTPATH=$(realpath "$0")
    SCRIPTDIR=$(dirname "$SCRIPTPATH")
    echo "$SCRIPTDIR"
}

export LIBPATH="$(scriptdir)/../lib"

file="$1"
shift

eval "$file" "$@"


