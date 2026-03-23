#!/bin/bash


choices_test_help() {
  choices -h 
}

choices_test_themecolor_list() {
  choices -tcl
}

choices_test_themeshape_list() {
  choices -tsl
}

choices_test_no_args() {
  choices  
}

choices_test_vacio() {
  choices -v -o "aopts_0"
}

choices_test_unico() {
  choices -v -o "aopts_1" -vo "salida"
  if [[ "$salida" != "" ]]; then
    echo -e "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_unico_autoselect() {
  choices -v -a -o "aopts_1" -vo "salida"
  if [[ "$salida" != "" ]]; then
    echo -e "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_simple() {
  choices -v -o "aopts_123" -vo "salida"
  if [[ "$salida" != "" ]]; then
    echo -e "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_labels() {
  choices -v -o "aopts_dias" -l "albls_dias" -vo "salida" -T "Seleccione\x20Dia"
  if [[ "$salida" != "" ]]; then
    echo -e "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_clean() {
  choices -o "aopts_meses" -l "albls_meses" -vo "salida" -T "Seleccione\x20Mes"
  if [[ "$salida" != "" ]]; then
    echo -e "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_no_impl() {
  choices -v -o "aopts_123" -vo "salida" -x "no-impl"
  if [[ "$salida" != "" ]]; then
    echo -e "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_indice() {
  choices -v -o "aopts_123"  -vo "salida" -i 1 
  if [[ "$salida" != "" ]]; then
    echo -e "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_title() {
  choices -v -o "aopts_123"  -vo "salida"  -T "choice\x20con\x20titulo" 
  if [[ "$salida" != "" ]]; then
    echo -e "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_themecolor() {
  choices -v -o "aopts_123"  -vo "salida"  -tc "ironman"
  if [[ "$salida" != "" ]]; then
    echo -e "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
  fi
}

choices_test_themeshape() {
  choices -v -o "aopts_123"  -vo "salida"  -ts "solid"
  if [[ "$salida" != "" ]]; then
    echo -e "\t Resultado  : " "[${SUCCESS}${salida}${RESET}]"
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
  )
}
