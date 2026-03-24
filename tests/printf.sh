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

test5() {
  str=$( strupper "Julian Vidal")
  echo ".$str."
}

test6() {
  str=$( strlower "Julian Vidal")
  echo ".$str."
}

test7() {
  str=$( replaceChar "Julian+Vidal" "+" "-" )
  echo ".$str."
}
clear

test1
test2
test3
test4
test5
test6
test7

