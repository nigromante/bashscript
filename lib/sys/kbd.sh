#!/bin/bash

kbd_readKey()
{
  local kp
  ESC=$'\e'
  _KEY=''
  read -d '' -sn1 _KEY
  case $_KEY in
    "$ESC")
        while read -d '' -sn1 -t.01 kp
        do
          _KEY=$_KEY$kp
          case $kp in
            [a-zA-NP-Z~]) break;;
          esac
        done
    ;;
  esac
  printf -v "${1:-_KEY}" "%s" "$_KEY"
}

