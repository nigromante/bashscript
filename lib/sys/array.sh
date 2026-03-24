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

  echo  -e "\t ------------------------------"
  echo  -e "\t Variable : ${WARNING}$1${RESET}"
  echo  -e "\t Length   : ${SUCCESS}${listalen}${RESET}"
  if [[ $listalen -gt 0 ]]; then
      echo  -e "\t List     : ${SUCCESS}${lista[*]}${RESET}"
      # echo  -e "\t Index    : ${SUCCESS}${!lista[@]}${RESET}"
      echo  -e "\t Items    : "
      for(( i=0 ; i < $listalen ; i++ )); do
          echo  -e "\t\t [${SUCCESS}$i${RESET}] : ${SUCCESS}${lista[$i]}${RESET}"
      done
  fi

}

