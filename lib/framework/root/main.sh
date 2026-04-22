#!/bin/bash


start() {
  
  sys_checkRoot 

  clear

  trap_hideCursor

  [[ $(type -t begin ) ]] && begin  $@

  [[ $(type -t layout_welcome) ]] && layout_welcome

  [[ $(type -t run) ]] && run $@

  [[ $(type -t finish) ]] && finish 

  vio_cursorShow
  
}

