#!/bin/bash

declare -A Modules
declare moduleVerbose=false


moduleVerbose() {
    moduleVerbose=true
}


moduleList() {
    if [[ $moduleVerbose == true ]]; then
        echo
        echo -e "\t Modulos cargados : " "${Modules[@]}"
        echo
    fi
}


moduleLoad() {
    if [[ -n "${Modules["$1"]}" ]]; then
        if [[ $moduleVerbose == true ]]; then
            echo "Module [$1] already loaded!"
        fi
        return
    fi
    Modules["$1"]="$1"
    folder="${LIBPATH}/$1"
    export MODULE="$folder"
    moduleLoadFile "_loader.sh"
}


moduleLoadFile() {
    file="${MODULE}/$1"
    if [[ $moduleVerbose == true ]]; then
        echo -e "\t file : [$file]"
    fi
    source  $file
}

