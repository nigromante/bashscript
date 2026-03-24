#!/bin/bash

source ${LIBPATH}/loader.sh

clear
echo "path: " $LIBPATH
echo
echo "functions :"
compgen -A function
echo

