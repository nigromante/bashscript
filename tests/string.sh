#!/bin/bash

source ${LIBPATH}/loader.sh

str_in_1="julian"
str_in_2="vidal"
str_in_3="JUlian Vidal Alarcon"
str_in_4="JUlian+Vidal+Alarcon"
str_in_5="julian enrique vidal alarcon"
str_in_6="JULian VIDAL alarcon"

test1() {
  str=$( strpadr "$str_in_1" 20 ) 
  echo -e "\n\t[${str_in_1}] >> [${str}]"
}

test2() {
  str=$( strpadl "$str_in_1" 20 ) 
  echo -e "\n\t[${str_in_1}] >> [${str}]"
}

test3() {
  str=$( strpadc "$str_in_1" 20 ) 
  echo -e "\n\t[${str_in_1}] >> [${str}]"
}

test4() {
  str=$( strpadc "$str_in_2" 20 ) 
  echo -e "\n\t[${str_in_2}] >> [${str}]"
}

test5() {
  str=$( strupper "$str_in_3" )
  echo -e "\n\t[${str_in_3}] >> [${str}]"
}

test6() {
  str=$( strlower "$str_in_3" )
  echo -e "\n\t[${str_in_3}] >> [${str}]"
}

test7() {
  str=$( strreplace "$str_in_4" "+" "-" )
  echo -e "\n\t[${str_in_4}] >> [${str}]"
}

test8() {
  str=$( strcap "$str_in_6" )
  echo -e "\n\t[${str_in_6}] >> [${str}]"
}

test9() {
  str=$( strcaptext "$str_in_5" )
  echo -e "\n\t[${str_in_5}] >> [${str}]"
}

test10() {
  str=$( strcaptext "$str_in_6" )
  echo -e "\n\t[${str_in_6}] >> [${str}]"
}


clear

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

echo
echo

