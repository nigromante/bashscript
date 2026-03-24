#!/bin/bash

  # usage :   linea=$(unescape "$texto")
unescape() {
    local patron1='s/\\[0-9]*\[[0-9]*\m//g'
    local patron2='s/\\[0-9]*\[[0-9]*;[0-9]*\m//g'
    local linea="$(echo $1 | sed -e $patron1)"
    linea="$(echo $linea | sed -e $patron2)"
    echo "$linea"
}

mklinea() {
    local patron0='s/\\x20/-/g'
    local patron1='s/[a-z]/-/g'
    local patron2='s/[A-Z]/-/g'
    local patron3='s/[0-9]/-/g'
    local patron4='s/\s/-/g'
    local patron5='s/./-/g'
    local linea="$( echo $1 | sed -e $patron0 )"
    linea="$( echo $linea | sed -e $patron1 )"
    linea="$( echo $linea | sed -e $patron2 )"
    linea="$( echo $linea | sed -e $patron3 )"
    linea="$( echo $linea | sed -e $patron4 )"
    linea="$( echo $linea | sed -e $patron5 )"
    echo "$linea"
  }
  
  replaceChar() {
    local patron0="s/$2/$3/g"
    local linea="$( echo $1 | sed -e $patron0 )"
    echo "$linea"
}

getLongest() {
	local longest=0
	local arr=$1[@]
	arr=("${!arr}")
  local length="${#arr[@]}"
  for (( i=0; i<$length; i++ )); do
	  if (( ${#arr[i]} > longest )); then
		  longest=${#arr[i]}
	  fi
  done
  echo "$longest"
}

getSize() {
	local arr=$1[@]
	arr=("${!arr}")
  local length="${#arr[@]}"
  echo "$length"
}

normalizeList() {
  size=$( getSize "$1" )
  length=$( getLongest "$1" )
  titlength="${#2}"
  if [[ $length < $titlength ]]; then
    length=$(( $titlength - 12 ))
  fi

  spaces=$(printf ' %.0s' $(eval "echo {1.."$(($length))"}"))
	local arr=$1[@]
	arr=("${!arr}")

  narr=()
  for(( i=0 ; i < $size ; i++ )); do
    currItem="${arr[$i]}"
	  currItemLength=${#currItem}
	  currItem=" ${spaces:0:0}${currItem}${spaces:currItemLength} "
    narr+=("$currItem")
  done
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

