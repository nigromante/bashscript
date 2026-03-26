#!/bin/bash

declare -A ModulesDisabled
declare -A Modules
declare moduleVerbose=false


moduleLoad() {
    if [[ -n "${Modules["$1"]}" ]]; then
        if [[ $moduleVerbose == true ]]; then
            echo "Module [$1] already loaded!"
        fi
        return
    fi
    if [[ -n "${ModulesDisabled["$1"]}" ]]; then
        if [[ $moduleVerbose == true ]]; then
            echo "Module [$1] disabled!"
        fi
        return
    fi
    Modules["$1"]="$1"
    folder="${LIBPATH}/$1"
    export MODULE="$folder"
    moduleLoadFile _loader.sh
}

moduleDisable() {
    ModulesDisabled["$1"]="$1"
}

moduleLoadLocal() {
    dir=$( basename "$PWD" )
    if [[ -n "${Modules["${dir}_$1"]}" ]]; then
        if [[ $moduleVerbose == true ]]; then
            echo "Module [${dir}/$1] already loaded!"
        fi
        return
    fi
    Modules["${dir}_$1"]="${dir}/$1"
    folder="$( pwd )/$1"
    export MODULE="$folder"
    moduleLoadFile _loader.sh
}


moduleLoadFile() {
    file="${MODULE}/$1"
    if [[ $moduleVerbose == true ]]; then
        echo -e "\t file : [$file]"
    fi
    source  $file
}


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


moduleListFunctions() {
    if [[ $moduleVerbose == true ]]; then
        echo
        echo "functions :"
        compgen -A function
        echo
    fi
}

