#!/bin/bash

PRESENTER="rofi"

info() {
    moduleVerbose

    moduleAppName
    moduleList 
    moduleDisabledList

    moduleSilent
}

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
  choices -p $PRESENTER -o "tests" -vo "test" -tc "loki" -ts "solid" -v
  if [[ "$test" != "" ]]; then
    clear
    echo -e "\t Resultado  : " "[${SUCCESS}${test}${RESET}]"
    eval "${test}"
  fi
}

