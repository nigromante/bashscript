#!/bin/bash


trace_list() {

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

