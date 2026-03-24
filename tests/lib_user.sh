#!/bin/bash

source ${LIBPATH}/loader_user.sh

clear
echo "path: " $LIBPATH
echo
echo "functions :"
compgen -A function
echo

