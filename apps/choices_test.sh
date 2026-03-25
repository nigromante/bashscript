#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    # moduleVerbose

    moduleLoad "menu"
    moduleLoad "sys"

    moduleList
}

source choices_test_list.sh
source choices_test_data.sh


all() {
  for(( itest=0;itest<${#tests[@]};itest++)); do
    test="${tests[$itest]}"
    clear
    echo -e "${GREEN}---------- [ ${YELLOW}" $test "${GREEN} ] ----------${RESET}"
    eval "${test}"
    echo
    echo -e "${YELLOW}--- Presione cualquier tecla para continuar ---${RESET}"
    _readkey "kkey"
  done
}


help() {
  echo
  echo "Usage"
  echo
  echo -e "\t" "$0" "help | all | list(default)" 
  echo
}


tmenu() {
  choices -o "tests" -vo "test" -tc "loki" -ts "solid" -v
  if [[ "$test" != "" ]]; then
    clear
    echo -e "\t Resultado  : " "[${SUCCESS}${test}${RESET}]"
    eval "${test}"
  fi
}


check() {
  if [[ "$1" == "help" ]]; then
    help
    return
  fi

  choices_test_list
  if [[ "$1" == "all" ]]; then
    all 
    return
  fi
  if [[ "$1" == "list" ]]; then
    tmenu
    return
  fi
  if [[ "$1" == "" ]]; then
    tmenu
    return
  fi


  echo -e "${ERROR}option error.${RESET}"
  help
}



loader_manager
check $@
