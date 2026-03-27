#!/bin/bash

PRESENTER="rofi"


all() {
  for(( itest=0;itest<${#tests[@]};itest++)); do
    test="${tests[$itest]}"
    clear
    vio_print "${GREEN}---------- [ ${YELLOW}" $test "${GREEN} ] ----------${RESET}"
    eval "${test}"
    vio_print "${YELLOW}--- Presione cualquier tecla para continuar ---${RESET}"
    kbd_readKey "kkey"
  done
}


help() {
  vio_print
  vio_print "Usage"
  vio_print
  vio_print "\t" "$0" "help | all | list(default)" 
  vio_print
}


tmenu() {
  choices -p $PRESENTER -o "tests" -vo "test" -tc "loki" -ts "solid" -v
  if [[ "$test" != "" ]]; then
    vio_print "\t Resultado  : " "[${SUCCESS}${test}${RESET}]"
    eval "${test}"
  fi
}

