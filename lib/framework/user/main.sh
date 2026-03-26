#!/bin/bash

start() {

  clear
  
  trap_hideCursor

  [[ $(type -t begin ) ]] && begin 

  [[ $(type -t welcome) ]] && welcome

  [[ $(type -t run) ]] && run

  [[ $(type -t bye) ]] && bye

  [[ $(type -t finish) ]] && finish 

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

