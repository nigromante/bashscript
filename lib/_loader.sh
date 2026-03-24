#!/bin/bash

loadModule() {
  lib="$1"
  folder="${LIBPATH}/${lib}"
  # var="LIB${lib^^}"
  export MODULE="$folder"
  source ${folder}/loader.sh
}

