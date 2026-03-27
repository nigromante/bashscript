#!/bin/bash

declare -A ModulesDisabled
declare -A Modules
declare moduleVerbose=false


moduleLoad() {
    if [[ -n "${Modules["$1"]}" ]]; then
        if [[ $moduleVerbose == true ]]; then
            vio_echo "Module [$1] already loaded!"
        fi
        return
    fi
    if [[ -n "${ModulesDisabled["$1"]}" ]]; then
        if [[ $moduleVerbose == true ]]; then
            vio_echo "Module [$1] disabled!"
        fi
        return
    fi
    Modules["$1"]="$1"
    folder="${LIBPATH}/$1"
    export MODULE="$folder"
    moduleLoadFile _loader.sh
}


moduleLoadLazy() {
    if [[ -n "${Modules["$1"]}" ]]; then
        if [[ $moduleVerbose == true ]]; then
            vio_echo "Module [$1] already loaded!"
        fi
        return
    fi
    if [[ -n "${ModulesDisabled["$1"]}" ]]; then
        if [[ $moduleVerbose == true ]]; then
            vio_echo "Module [$1] disabled!"
        fi
        return
    fi
    Modules["$1"]="-$1-"
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
            vio_echo "Module [${dir}/$1] already loaded!"
        fi
        return
    fi
    Modules["${dir}_$1"]="[${dir}/$1]"
    folder="$( pwd )/$1"
    export MODULE="$folder"
    moduleLoadFile _loader.sh
}


moduleLoadFile() {
    file="${MODULE}/$1"
    if [[ $moduleVerbose == true ]]; then
        vio_echo "\t file : [$file]"
    fi
    source  $file
}


moduleVerbose() {
    moduleVerbose=true
}


moduleSilent() {
    moduleVerbose=false
}


moduleList() { 
    if [[ $moduleVerbose == true ]]; then
        vio_echo
        vio_echo "\t Modulos cargados : " "${Modules[@]}"
        vio_echo
    fi
}


moduleDisabledList() { 
    if [[ $moduleVerbose == true ]]; then
        vio_echo
        vio_echo "\t Modulos excluidos : " "${ModulesDisabled[@]}"
        vio_echo
    fi
}


moduleListFunctions() {
    if [[ $moduleVerbose == true ]]; then
        vio_echo
        vio_echo "functions :"
        compgen -A function
        vio_echo
    fi
}


moduleAppName() {
    if [[ $moduleVerbose == true ]]; then
        name=$( basename "$0")
        vio_echo
        vio_echo "\t App : " "$PWD/$name"
        vio_echo
    fi
}

moduleInfo() {
    moduleVerbose

    moduleAppName
    moduleList 
    moduleDisabledList

    moduleSilent
}