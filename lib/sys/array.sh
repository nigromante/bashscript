#!/bin/bash

#  length=$( getLongest "arrayName" )
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

#  size=$( getSize "arrayName" )
getSize() {
	local arr=$1[@]
	arr=("${!arr}")
  local length="${#arr[@]}"
  echo "$length"
}
