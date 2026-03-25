#!/bin/bash

declare -a opciones2

choices_menu_loader() {
    opciones2=()
    title=$( echo -e "$title" )
    if [[ $labelsLength > 0 ]]; then
      for(( i=0 ; i < $itemsLength ; i++ )); do
        opciones2+=("${menuItems[$i]}:${labelItems[$i]}")
      done
    else
      for(( i=0 ; i < $itemsLength ; i++ )); do
        opciones2+=("${menuItems[$i]}:${menuItems[$i]}")
      done
    fi
    opciones=$(IFS="|"; echo "${opciones2[*]}")
}

choices_return() {
    choice=$( echo "$1" | awk -F : '{ print $1 }' )
    printf -v "$result" "$choice"
}

choices_menu_run() {
    choice=$( echo -e  "$opciones" | rofi -sep '|' -dmenu -p "Seleccionar" -window-title="$title" -display-columns="1" -display-column-separator=':' )
    choices_return "$choice"
}
