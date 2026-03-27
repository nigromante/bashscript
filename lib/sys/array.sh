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

  vio_echo "\t ------------------------------"
  vio_echo "\t Variable : ${WARNING}$1${RESET}"
  vio_echo "\t Length   : ${SUCCESS}${listalen}${RESET}"
  if [[ $listalen -gt 0 ]]; then
      vio_echo "\t List     : ${SUCCESS}${lista[*]}${RESET}"
      vio_echo "\t Index    : ${SUCCESS}${!lista[@]}${RESET}"
      vio_echo "\t Items    : "
      for(( i=0 ; i < $listalen ; i++ )); do
          vio_echo "\t\t [${SUCCESS}$i${RESET}] : ${SUCCESS}${lista[$i]}${RESET}"
      done
  fi

}

