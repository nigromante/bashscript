#!/bin/bash

menutheme_color_config() {
  CONFIG="$(pwd)/$0.cfg.theme.color"
}


menutheme_color_read() {
  menutheme_color_config
  if [[ ! -a $CONFIG ]]; then
    echo "0:${menutheme_color_names[0]}" > $CONFIG
  fi
  if [[ "$theme" == "" ]]; then
    menutheme_color_default=$(awk -F : '{print $2}' $CONFIG)
    menutheme_theme_id=$(awk -F : '{print $1}' $CONFIG)
    theme=$menutheme_color_default 
  fi
  menutheme_color_set "$theme"
}


menutheme_color_write() {
  menutheme_color_config
  echo "${menutheme_theme_id}:${menutheme_color_default}" > $CONFIG
}


menutheme_color_switch() {
    menutheme_theme_id=$((menutheme_theme_id+1))
    (( $menutheme_color_n == $menutheme_theme_id )) && menutheme_theme_id=0
    menutheme_color_default="${menutheme_color_names[$menutheme_theme_id]}" 
    theme=$menutheme_color_default
    menutheme_color_set "$theme"
}
