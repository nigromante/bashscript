#!/bin/bash

source ${LIBPATH}/loader_root.sh

clear
echo "path: " $LIBPATH
echo
echo "functions :"
compgen -A function
echo

