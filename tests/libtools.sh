#!/bin/bash

source ${LIBTPATH}/loader_user.sh

clear
echo "path: " $LIBTPATH
echo
echo "functions :"
compgen -A function
echo "message"
