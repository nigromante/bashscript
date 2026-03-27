#!/bin/bash

trap_hideCursor() {
  vio_cursorHide
  trap 'vio_error "${BR} Break ! ${BR}"  && trap_showCursor && exit "0"'  SIGINT
}

trap_showCursor() {
  vio_cursorShow
  trap - SIGINT
}

