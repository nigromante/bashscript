#!/bin/bash

SOURCE=${BASH_SOURCE[0]}
LIBPATH="$( dirname $SOURCE )"

LOADER_PATH="$LIBPATH/_loader"

source $LOADER_PATH/const.sh
source $LOADER_PATH/sys.sh
source $LOADER_PATH/print.sh
source $LOADER_PATH/vio.sh
source $LOADER_PATH/module.sh
source $LOADER_PATH/module_extra.sh
