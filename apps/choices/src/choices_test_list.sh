#!/bin/bash

PRESENTER_TEST="menu"


choices_test_help() {
  choices -p $PRESENTER_TEST -h 
}

choices_test_themecolor_list() {
  choices -p $PRESENTER_TEST -tcl
}

choices_test_themeshape_list() {
  choices -p $PRESENTER_TEST -tsl
}

choices_test_includes() {
    ldr_mod_verbose
    ldr_mod_list
    ldr_mod_list_functions
    ldr_mod_silent
}

choices_test_no_args() {
  choices -p $PRESENTER_TEST  
}

choices_test_vacio() {
  choices -p $PRESENTER_TEST -v -o "aopts_0"
}

choices_test_unico() {
  choices -p $PRESENTER_TEST -v -o "aopts_1" -vo "salida"
  if [[ "$salida" != "" ]]; then
    vio_print "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_unico_autoselect() {
  choices -p $PRESENTER_TEST -v -a -o "aopts_1" -vo "salida"
  if [[ "$salida" != "" ]]; then
    vio_print "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_simple() {
  choices -p $PRESENTER_TEST -v -o "aopts_123" -vo "salida"
  if [[ "$salida" != "" ]]; then
    vio_print "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_labels() {
  choices -p $PRESENTER_TEST -v -o "dias_opts" -l "dias_lbls" -vo "salida" -T "Seleccione\x20Dia"
  if [[ "$salida" != "" ]]; then
    vio_print "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_clean() {
  choices -p $PRESENTER_TEST -o "meses_opts" -l "meses_lbls" -vo "salida" -T "Seleccione\x20Mes"
  if [[ "$salida" != "" ]]; then
    vio_print "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
    ldr_mod_verbose
    ldr_mod_list
    ldr_mod_list_functions
    ldr_mod_silent
}

choices_test_no_impl() {
  choices -p $PRESENTER_TEST -v -o "aopts_123" -vo "salida" -x "no-impl"
  if [[ "$salida" != "" ]]; then
    vio_print "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_indice() {
  choices -p $PRESENTER_TEST -v -o "aopts_123"  -vo "salida" -i 1 
  if [[ "$salida" != "" ]]; then
    vio_print "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_title() {
  choices -p $PRESENTER_TEST -v -o "aopts_123"  -vo "salida"  -T "choice\x20con\x20titulo" 
  if [[ "$salida" != "" ]]; then
    vio_print "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_themecolor() {
  choices -p $PRESENTER_TEST -v -o "aopts_123"  -vo "salida"  -tc "ironman"
  if [[ "$salida" != "" ]]; then
    vio_print "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_themeshape() {
  choices -p $PRESENTER_TEST -v -o "aopts_123"  -vo "salida"  -ts "solid"
  if [[ "$salida" != "" ]]; then
    vio_print "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_list() {
  tests=(
    "choices_test_help"
    "choices_test_themecolor_list"
    "choices_test_themeshape_list"
    "choices_test_no_args"
    "choices_test_vacio"
    "choices_test_unico"
    "choices_test_unico_autoselect"
    "choices_test_simple"
    "choices_test_labels"
    "choices_test_no_impl"
    "choices_test_indice"
    "choices_test_title"
    "choices_test_themecolor"
    "choices_test_themeshape"
    "choices_test_clean"
    "choices_test_includes"
  )
}
