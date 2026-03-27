#!/bin/bash

#  length=$( arrayGetLongest "arrayName" )
arrayGetLongest() {
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

#  size=$( arrayGetSize "arrayName" )
arrayGetSize() {
	local arr=$1[@]
	arr=("${!arr}")
  local length="${#arr[@]}"
  echo "$length"
}

arrayTrace() {

  lista=$1[@]
	lista=("${!lista}")
  listalen="${#lista[@]}"

  vio_print "\t ------------------------------"
  vio_print "\t Variable : ${WARNING}$1${RESET}"
  vio_print "\t Length   : ${SUCCESS}${listalen}${RESET}"
  if [[ $listalen -gt 0 ]]; then
      vio_print "\t List     : ${SUCCESS}${lista[*]}${RESET}"
      vio_print "\t Index    : ${SUCCESS}${!lista[@]}${RESET}"
      vio_print "\t Items    : "
      for(( i=0 ; i < $listalen ; i++ )); do
          vio_print "\t\t [${SUCCESS}$i${RESET}] : ${SUCCESS}${lista[$i]}${RESET}"
      done
  fi

}

