#!/bin/bash

source ${LIBPATH}/loader_user.sh


init() {
    setAuthor       "JULIAN VIDAL A"
    setTitle        "test normalizeList"
    setDescription  " - ajustar lista -"

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

start

