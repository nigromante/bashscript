#!/bin/bash


choices_entry() {
  if [[ "$1" == "info" ]]; then
    info 
    return
  fi

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
