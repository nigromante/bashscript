#!/bin/bash

menutheme_shape_config() {
  CONFIG="$(pwd)/.config/theme.shape"
}


menutheme_shape_getNames() {
  echo "${menutheme_shape_names[@]}"
}


menutheme_shape_read() {
  menutheme_shape_config
  if [[ ! -a $CONFIG ]]; then
    echo "0:${menutheme_shape_names[0]}" > $CONFIG
  fi
  if [[ "$shape" == "" ]]; then
    menutheme_shape_default=$(awk -F : '{print $2}' $CONFIG)
    menutheme_shape_id=$(awk -F : '{print $1}' $CONFIG)
    shape=$menutheme_shape_default
  fi
  menutheme_shape_set "$shape"
}


menutheme_shape_write() {
  menutheme_shape_config
  echo "${menutheme_shape_id}:${menutheme_shape_default}" > $CONFIG
}


menutheme_shape_switch() {
    menutheme_shape_id=$((menutheme_shape_id+1))
    (( $menutheme_shape_n == $menutheme_shape_id )) && menutheme_shape_id=0
    menutheme_shape_default="${menutheme_shape_names[$menutheme_shape_id]}" 
    shape=$menutheme_shape_default
    menutheme_shape_set "$shape"
}
  
