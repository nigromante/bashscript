#!/bin/bash


choices_menu_loader() {
    echo -n ""
}

choices_menu_run() {
    title=$( echo -e "$title" )
    choice=$( echo -e  "${menuItems[@]}" | rofi -sep ' ' -dmenu -p "Seleccionar" -window-title="$title" )
    printf -v "$result" "$choice"
}
