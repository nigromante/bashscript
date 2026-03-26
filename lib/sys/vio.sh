#!/bin/bash


setColor() {
    echo -e -n "$1"
}


resetColor() {
    echo -e -n "${RESET}"
}


nl() {
    echo -e "${BR}"
}


print () {
    echo -e "${BLANK}$1${RESET}"
}


error( ) {
    echo -e "${BR}${ERROR}Error   : $1${RESET}"
}


success( ) {
    echo -e "${BR}${SUCCESS}Success : $1${RESET}"
}


warning( ) {
    echo -e "${BR}${WARNING}Warning : $1${RESET}"
}


info( ) {
    echo -e "${BR}${INFO}Info    : $1${RESET}"
}


cursor_hide() {
      print "${CURSOR_HIDE}"
}


cursor_show() {
      print "${CURSOR_SHOW}"
}

upLines() {
  echo -en "\033[${1}A"
  # tput ed
}
