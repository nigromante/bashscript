#!/usr/bin/env bash


peval_theme_none() {
  PEVALTHEME_FRAME=""
  PEVALTHEME_CMD=""
  PEVALTHEME_RESULT=""
  PEVALTHEME_ERROR=""
  PEVALTHEME_OPEN_LEFT=""
  PEVALTHEME_OPEN_RIGHT=""
  PEVALTHEME_CLOSE=""
}

peval_theme_vision() {
  PEVALTHEME_FRAME=$YELLOW
  PEVALTHEME_CMD=$PURPLE
  PEVALTHEME_RESULT=$GREEN
  PEVALTHEME_ERROR=$RED
  PEVALTHEME_OPEN_LEFT=" --- cmd: [ \n"
  PEVALTHEME_OPEN_RIGHT="\n ] --- "
  PEVALTHEME_CLOSE="\n--- X ---\n"
}


peval_mode_debug() {
  peval_print=true
  peval_print_result=true
  peval_exec=true
}

peval_mode_command() {
  peval_print=true
  peval_print_result=false
  peval_exec=false
}

peval_mode_exec_only() {
  peval_print=false
  peval_print_result=false
  peval_exec=true
}

peval_mode_silent() {
  peval_print=false
  peval_print_result=false
  peval_exec=false
}

peval_mode_result() {
  peval_print=false
  peval_print_result=true
  peval_exec=true
}


# default 
peval_theme_none
peval_mode_debug



peval() {

  cmd="$@"
  cmdtext="$@"
  result=""
  rcode=9999
  
  # print command
  cmdtext=$( echo "$cmdtext" | sed 's/\ -/\n\t-/g' )
  [[ $peval_print == true ]] &&    echo -e "${PEVALTHEME_FRAME}${PEVALTHEME_OPEN_LEFT}${PEVALTHEME_CMD}$cmdtext${PEVALTHEME_FRAME}${PEVALTHEME_OPEN_RIGHT}${RESET}"

  # execute
  [[ $peval_exec == true ]] &&  result=$( eval "$cmd" ) && rcode=$?

  # result$cmd
  [[ $peval_print_result == true && $rcode == 9999 ]] && echo -e "${PEVALTHEME_ERROR}error al ejecutar comando${PEVALTHEME_FRAME}${PEVALTHEME_CLOSE}${RESET}" &&  exit 1 
  [[ $peval_print_result == true && !($rcode == 0) ]] && echo -e "${PEVALTHEME_ERROR}${result}${PEVALTHEME_FRAME}${PEVALTHEME_CLOSE}${RESET}" && exit 1 
  [[ $peval_print_result == true && $rcode == 0 ]]    && echo -e "${PEVALTHEME_RESULT}${result}${PEVALTHEME_FRAME}${PEVALTHEME_CLOSE}${RESET}"

}


