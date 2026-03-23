#!/bin/bash

LIBPATH="$(pwd)/../lib"
source ${LIBPATH}/loader.sh

init() {
    lista=( "uno" "ls" "lotr"  "julian vidal alarcon" )
    titulo="titulo del menu"
    normalizeList "lista" "$titulo"
}

run() {
  echo -e "$titulo"
  len="${#narr[@]}"
  for(( i=0 ; i < $len ; i++ )); do
    echo "|  X  ${narr[$i]}|"
  done
  #echo
}

start() {
  init
  run
}

start
