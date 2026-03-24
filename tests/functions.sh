#!/bin/bash

LIBPATH="$(pwd)/../lib"
source ${LIBPATH}/loader_root.sh

echo "List of all functions:"
compgen -A function
echo

