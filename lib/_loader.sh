#!/bin/bash


# ----------------------------------
RESET="\033[0m"
RED='\033[0;31m'
GREEN='\033[0;32m'
PURPLE='\033[0;35m'
YELLOW='\033[1;33m'

ERROR="${RED}"
SUCCESS=${GREEN}
WARNING=${YELLOW}
INFO=${PURPLE}
BLANK=${RESET}


# ----------------------------------
# Output
declare -A ModulesDisabled
declare -A Modules
declare ldr_mod_verbose=false


sys_appWorkDir() {
    local SCRIPTPATH=$(realpath "$0")
    SCRIPTDIR=$(dirname "$SCRIPTPATH")
    echo "$SCRIPTDIR"
}


sys_pwd() {
    PWD=$(pwd)
    echo "$PWD"
}


sys_print() {
  [[ $ldr_mod_verbose == true ]] &&  echo -e "$@"
}


sys_error() {
  [[ $ldr_mod_verbose == true ]] &&  echo -e "${ERROR}$@${BLANK}"
}


sys_warning() {
  [[ $ldr_mod_verbose == true ]] &&  echo -e "${WARNING}$@${BLANK}"
}


sys_success() {
  [[ $ldr_mod_verbose == true ]] &&  echo -e "${SUCCESS}$@${BLANK}"
}


sys_info() {
  [[ $ldr_mod_verbose == true ]] &&  echo -e "${INFO}$@${BLANK}"
}


ldr_insmod() {
    sys_info "Loading Module [${WARNING}$1${INFO}] "
    if [[ -n "${Modules["$1"]}" ]]; then
        sys_warning "Module [$1] already loaded!"
         return
    fi
    if [[ -n "${ModulesDisabled["$1"]}" ]]; then
        sys_error "Module [$1] disabled!"
        return
    fi
    Modules["$1"]="$1"
    folder="${LIBPATH}/$1"
    export MODULE="$folder"
    ldr_insfile _loader.sh
}


ldr_insmod_lazy() {
    sys_info "Loading Module Lazy [${WARNING}$1${INFO}] "
    if [[ -n "${Modules["$1"]}" ]]; then
        sys_warning "Module [$1] already loaded!"
        return
    fi
    if [[ -n "${ModulesDisabled["$1"]}" ]]; then
        sys_error "Module [$1] disabled!"
        return
    fi
    Modules["$1"]="-$1-"
    folder="${LIBPATH}/$1"
    export MODULE="$folder"
    ldr_insfile _loader.sh
}


ldr_insfile() {
    file="$MODULE/$1"
    sys_success "\t file : [${WARNING}$1${SUCCESS}]"
    source  $file
}


ldr_insmod_local() {
    dir=$( sys_appWorkDir )
    dir=$( basename "$dir" )
    sys_info "Loading Module Local [${WARNING}${dir}/$1${INFO}] "
    if [[ -n "${Modules["${dir}_$1"]}" ]]; then
        sys_warning "Module [${dir}/$1] already loaded!"
        return
    fi
    Modules["${dir}_$1"]="[${dir}/$1]"
    ldr_insfile_local _loader.sh
}


ldr_insfile_local() {
    file="$(sys_appWorkDir)/src/$1"
    sys_success "\t file : [${WARNING}$file${SUCCESS}]"
    source  $file
}


ldr_mod_disable() {
    sys_info "Module Disabling : ${WARNING}$1${INFO} "
    ModulesDisabled["$1"]="$1"
}


ldr_mod_verbose() {
    ldr_mod_verbose=true
}


ldr_mod_silent() {
    ldr_mod_verbose=false
}


ldr_mod_list() {
    sys_info "\n\t Modulos cargados : " "${WARNING}${Modules[@]}${INFO}"
}


ldr_mod_disabled_list() {
    sys_info "\n\t Modulos excluidos : " "${WARNING}${ModulesDisabled[@]}${INFO}"  
}


ldr_mod_list_functions() {
    sys_info "\nfunctions :\n"
    list=$(compgen -A function)
    for fn in $list ; do
        sys_success "\t" $fn
    done
}


ldr_mod_app_name() {
    sys_info "\n\t App : " "[${WARNING}$0${INFO}]"
}


moduleInfo() {
    ldr_mod_verbose

    ldr_mod_app_name
    ldr_mod_list 
    ldr_mod_disabled_list
    ldr_mod_list_functions

    ldr_mod_silent
}

