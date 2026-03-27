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

vio_echo() {
    echo -e "$1"
}


print() {
    echo -e "${BLANK}$1${RESET}"
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


cursor_hide() {
    echo -e -n "${CURSOR_HIDE}"
}


cursor_show() {
    echo -e -n "${CURSOR_SHOW}"
}

upln() {
  echo -en "\033[${1}A"
  # tput ed
}
