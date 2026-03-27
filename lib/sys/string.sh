#!/bin/bash

#  str=$( str_replace "julian+vidal" "+" "-" ) 
str_replace() {
  local patron0="s/$2/$3/g"
  local linea="$( echo "$1" | sed -e $patron0 )"
  echo "$linea"
}

#  str=$( str_padr "julian" 20 ) 
str_padr() {
  echo "$( printf '%*s' $2 "$1" )"
}

#  str=$( str_padl "julian" 20 ) 
str_padl() {
  echo "$( printf '%-*s' $2 "$1" )"
}

#  str=$( str_padc "vidal" 20 ) 
str_padc() {
  resto=$(( ($2 + ${#1}) / 2 ))
  str1=$( str_padr "$1" $resto ) 
  str2=$( str_padl  "$str1"  $2 ) 
  echo "$str2" 
}

#  str=$( str_cap "julian vidal")
str_cap() {
  str="$1"
  str="${str,,}"
  echo "${str^}"
}

#  str=$( str_captext "julian vidal")
str_captext() {
  words="${1,,}"
  words=($words)
  for i in "${!words[@]}"; do
    words[$i]="${words[$i]^}"
  done
  CAPITALIZED_STRING="${words[*]}"
  echo "${CAPITALIZED_STRING}"
}

#  str=$( str_upper "Julian Vidal")
str_upper() {
  str="$1"
  echo "${str^^}"
}

#  str=$( str_lower "Julian Vidal")
str_lower() {
  str="$1"
  echo "${str,,}"
}

