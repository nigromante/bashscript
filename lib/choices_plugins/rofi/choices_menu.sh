#!/bin/bash

declare -a opciones2

rofi_menu_loader() {
    opciones2=()
    title=$( echo -e "$title" )
    if [[ $labelsLength > 0 ]]; then
      for(( i=0 ; i < $itemsLength ; i++ )); do
        opciones2+=("${menuItems[$i]} : ${labelItems[$i]}")
      done
    else
      for(( i=0 ; i < $itemsLength ; i++ )); do
      opciones2+=("${menuItems[$i]}")
      done
    fi
    opciones=$(IFS="|"; echo "${opciones2[*]}")
}

rofi_return() {
    choice=$( echo "$1" | awk -F : '{ print $1 }' )
    printf -v "$result" "$choice"
}

rofi_menu_run() {
    choice=$( echo -e  "$opciones" | rofi -sep '|' -dmenu -p "${title} " )
    rofi_return "$choice"
}
