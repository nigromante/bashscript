#!/bin/bash

start() {

  check_root 

  trap_hideCursor

  init

  welcome

  run

  bye

  cursor_show

}



setAuthor() {
  APP_AUTHOR="$1"
}

setTitle() {
  APP_TITLE="$1"
}

setDescription() {
  APP_DESCRIPTION="$1"
}
