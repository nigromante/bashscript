#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad sys
}


str_in_1="julian"
str_in_2="vidal"
str_in_3="JUlian Vidal Alarcon"
str_in_4="JUlian+Vidal+Alarcon"
str_in_5="julian enrique vidal alarcon"
str_in_6="JULian VIDAL alarcon"

test1() {
  str=$( strpadr "$str_in_1" 20 ) 
  vio_echo "\n\t[${str_in_1}] >> [${str}]"
}

test2() {
  str=$( strpadl "$str_in_1" 20 ) 
  vio_echo "\n\t[${str_in_1}] >> [${str}]"
}

test3() {
  str=$( strpadc "$str_in_1" 20 ) 
  vio_echo "\n\t[${str_in_1}] >> [${str}]"
}

test4() {
  str=$( strpadc "$str_in_2" 20 ) 
  vio_echo "\n\t[${str_in_2}] >> [${str}]"
}

test5() {
  str=$( strupper "$str_in_3" )
  vio_echo "\n\t[${str_in_3}] >> [${str}]"
}

test6() {
  str=$( strlower "$str_in_3" )
  vio_echo "\n\t[${str_in_3}] >> [${str}]"
}

test7() {
  str=$( strreplace "$str_in_4" "+" "-" )
  vio_echo "\n\t[${str_in_4}] >> [${str}]"
}

test8() {
  str=$( strcap "$str_in_6" )
  vio_echo "\n\t[${str_in_6}] >> [${str}]"
}

test9() {
  str=$( strcaptext "$str_in_5" )
  vio_echo "\n\t[${str_in_5}] >> [${str}]"
}

test10() {
  str=$( strcaptext "$str_in_6" )
  vio_echo "\n\t[${str_in_6}] >> [${str}]"
}





main() {
  test1
  test2
  test3
  test4
  test5
  test6
  test7
  test8
  test9
  test10
}

clear
loader_manager
main
echo "--- FIN ---"

