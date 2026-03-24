#!/bin/bash

LIBPATH="$(pwd)/../lib"
source ${LIBPATH}/loader.sh

test1() {
  str=$( padright "julian" 20 ) 
  echo ".$str."
}

test2() {
  str=$( padleft "julian" 20 ) 
  echo ".$str."
}

test3() {
  str=$( padcenter "julian" 20 ) 
  echo ".$str."
}

test4() {
  str=$( padcenter "vidal" 20 ) 
  echo ".$str."
}


clear

test1
test2
test3
test4


