#!/bin/bash

scriptdir() {
    local SCRIPTPATH=$(realpath "$0")
    SCRIPTDIR=$(dirname "$SCRIPTPATH")
    echo "$SCRIPTDIR"
}

_running_dir=$( pwd )
_script_dir=$( scriptdir )

echo "Running dir : [$_running_dir]"
echo "Script dir  : [$_script_dir]"
