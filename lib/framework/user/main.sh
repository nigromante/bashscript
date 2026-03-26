#!/bin/bash


start() {

  clear
  
  trap_hideCursor

  [[ $(type -t begin ) ]] && begin 

  [[ $(type -t welcome) ]] && welcome

  [[ $(type -t run) ]] && run

  [[ $(type -t finish) ]] && finish 

  cursor_show

}


