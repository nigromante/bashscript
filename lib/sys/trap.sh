#!/bin/bash

trap_hideCursor() {
  cursor_hide
  trap 'vio_error "${BR} Break ! ${BR}"  && trap_showCursor && exit "0"'  SIGINT
}

trap_showCursor() {
  cursor_show
  trap - SIGINT
}

