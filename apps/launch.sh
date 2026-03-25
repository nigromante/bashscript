#!/bin/bash

#  -----------------------------------------------------------------------------
# when need launch a app with root privileges
#
# sudo dont recognizes env variables  $LIBPATH is used to locate lib sources.
#
# this script simplifies it:
# example:
#     from apps folder
#         sudo ./launch.sh ./tests/libtools.sh arg1 arg2
#
#     from tests folder
#         sudo ../launch.sh ./libtools.sh arg1 arg2
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


