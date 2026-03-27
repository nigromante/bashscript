#!/bin/bash

PRESENTER="rofi"


all() {
  for(( itest=0;itest<${#tests[@]};itest++)); do
    test="${tests[$itest]}"
    clear
    vio_echo "${GREEN}---------- [ ${YELLOW}" $test "${GREEN} ] ----------${RESET}"
    eval "${test}"
    vio_echo "${YELLOW}--- Presione cualquier tecla para continuar ---${RESET}"
    _readkey "kkey"
  done
}


help() {
  vio_echo
  vio_echo "Usage"
  vio_echo
  vio_echo "\t" "$0" "help | all | list(default)" 
  vio_echo
}


tmenu() {
  choices -p $PRESENTER -o "tests" -vo "test" -tc "loki" -ts "solid" -v
  if [[ "$test" != "" ]]; then
    vio_echo "\t Resultado  : " "[${SUCCESS}${test}${RESET}]"
    eval "${test}"
  fi
}

