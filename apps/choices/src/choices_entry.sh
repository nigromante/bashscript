#!/bin/bash


choices_test_entry() {

  if [[ "$1" == "info" ]]; then
    moduleInfo 
    return
  fi

  if [[ "$1" == "help" ]]; then
    choices_test_entry_help
    return
  fi

  choices_test_list    # carga lista de tests

  if [[ "$1" == "all" ]]; then
    choices_test_entry_all 
    return
  fi
  if [[ "$1" == "list" ]]; then
    choices_test_entry_tmenu
    return
  fi
  if [[ "$1" == "" ]]; then
    choices_test_entry_tmenu
    return
  fi


  vio_error "wrong parameter, check help"
  choices_test_entry_help
}
