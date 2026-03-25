#!/bin/bash

start() {

  clear
  
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

