#!/bin/bash


sys_print() {
  [[ $ldr_mod_verbose == true ]] &&  echo -e "$@"
}


sys_error() {
  [[ $ldr_mod_verbose == true ]] &&  echo -e "${ERROR}$@${BLANK}"
}


sys_warning() {
  [[ $ldr_mod_verbose == true ]] &&  echo -e "${WARNING}$@${BLANK}"
}


sys_success() {
  [[ $ldr_mod_verbose == true ]] &&  echo -e "${SUCCESS}$@${BLANK}"
}


sys_info() {
  [[ $ldr_mod_verbose == true ]] &&  echo -e "${INFO}$@${BLANK}"
}

