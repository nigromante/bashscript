#!/bin/bash

#  str=$( strreplace "julian+vidal" "+" "-" ) 
strreplace() {
  local patron0="s/$2/$3/g"
  local linea="$( echo "$1" | sed -e $patron0 )"
  echo "$linea"
}

#  str=$( strpadr "julian" 20 ) 
strpadr() {
  echo "$( printf '%*s' $2 "$1" )"
}

#  str=$( strpadl "julian" 20 ) 
strpadl() {
  echo "$( printf '%-*s' $2 "$1" )"
}

#  str=$( strpadc "vidal" 20 ) 
strpadc() {
  resto=$(( ($2 + ${#1}) / 2 ))
  str1=$( strpadr "$1" $resto ) 
  str2=$( strpadl  "$str1"  $2 ) 
  echo "$str2" 
}

#  str=$( strcap "julian vidal")
strcap() {
  str="$1"
  str="${str,,}"
  echo "${str^}"
}

#  str=$( strcaptext "julian vidal")
strcaptext() {
  words="${1,,}"
  words=($words)
  for i in "${!words[@]}"; do
    words[$i]="${words[$i]^}"
  done
  CAPITALIZED_STRING="${words[*]}"
  echo "${CAPITALIZED_STRING}"
}

#  str=$( strupper "Julian Vidal")
strupper() {
  str="$1"
  echo "${str^^}"
}

#  str=$( strlower "Julian Vidal")
strlower() {
  str="$1"
  echo "${str,,}"
}

