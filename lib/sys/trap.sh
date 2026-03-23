#!/bin/bash

trap_hideCursor() {
  cursor_hide
  trap 'print "${BR}${ERROR} Break ! ${RESET}${BRx2}"  && trap_showCursor && exit "0"'  SIGINT
}

trap_showCursor() {
  cursor_show
  trap - SIGINT
}

