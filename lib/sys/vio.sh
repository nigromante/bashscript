#!/bin/bash


vio_setColor() {
    echo -e -n "$1"
}


vio_resetColor() {
    echo -e -n "${RESET}"
}


vio_print() {
    echo -e "$1"
}


vio_error() {
    echo -e "${BR}${ERROR}Error   : $1${RESET}"
}


vio_success() {
    echo -e "${BR}${SUCCESS}Success : $1${RESET}"
}


vio_warning() {
    echo -e "${BR}${WARNING}Warning : $1${RESET}"
}


vio_info() {
    echo -e "${BR}${INFO}Info    : $1${RESET}"
}


vio_cursorHide() {
    echo -e -n "${CURSOR_HIDE}"
}


vio_cursorShow() {
    echo -e -n "${CURSOR_SHOW}"
}


vio_nl() {
    echo -e "${BR}"
}


vio_upLine() {
  echo -en "\033[${1}A"
  # tput ed
}
