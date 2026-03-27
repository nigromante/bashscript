#!/bin/bash


choices_entry() {
  if [[ "$1" == "info" ]]; then
    moduleInfo 
    return
  fi

  if [[ "$1" == "help" ]]; then
    choices_entry_help
    return
  fi

  choices_test_list
  if [[ "$1" == "all" ]]; then
    choices_entry_all 
    return
  fi
  if [[ "$1" == "list" ]]; then
    choices_entry_tmenu
    return
  fi
  if [[ "$1" == "" ]]; then
    choices_entry_tmenu
    return
  fi


  vio_error "wrong parameter, check help"
  choices_entry_help
}
