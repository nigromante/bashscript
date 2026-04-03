#!/usr/bin/env bash

PEVALTHEME_FRAME=$YELLOW
PEVALTHEME_CMD=$PURPLE
PEVALTHEME_RESULT=$GREEN
PEVALTHEME_ERROR=$RED
PEVALTHEME_CLOSE="------------------------------------\n"

peval_print=true
peval_exec=true

peval() {
  cmd="$1"
  result=""
  rcode=9999
  [[ $peval_print == true ]] &&    echo -e "${PEVALTHEME_FRAME}cmd : [ ${PEVALTHEME_CMD}${cmd}${PEVALTHEME_FRAME} ] ${RESET}"
  [[ $peval_exec == true ]] &&  result=$( eval "$cmd" ) && rcode=$?
  [[ $peval_print == true && $rcode == 9999 ]] && echo -e "${PEVALTHEME_ERROR}error al ejecutar comando${PEVALTHEME_FRAME}\n${PEVALTHEME_CLOSE}${RESET}" &&  exit 1 
  [[ $peval_print == true && !($rcode == 0) ]] &&  echo -e "${PEVALTHEME_ERROR}${result}${PEVALTHEME_FRAME}\n${PEVALTHEME_CLOSE}${RESET}" && exit 1 
  [[ $peval_print == true && $rcode == 0 ]]    &&  ( echo -e "${PEVALTHEME_RESULT}${result}${PEVALTHEME_FRAME}\n${PEVALTHEME_CLOSE}${RESET}"; return )
}


