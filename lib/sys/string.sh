#!/bin/bash

replaceChar() {
    local patron0="s/$2/$3/g"
    local linea="$( echo "$1" | sed -e $patron0 )"
    echo "$linea"
}

#  str=$( padright "julian" 20 ) 
padright() {
  echo "$( printf '%*s' $2 "$1" )"
}

#  str=$( padleft "julian" 20 ) 
padleft() {
  echo "$( printf '%-*s' $2 "$1" )"
}

#  str=$( padcenter "vidal" 20 ) 
padcenter() {
  resto=$(( ($2 + ${#1}) / 2 ))
  str1=$( padright "$1" $resto ) 
  str2=$( padleft  "$str1"  $2 ) 
  echo "$str2" 
}

