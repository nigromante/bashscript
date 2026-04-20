#!/usr/bin/env bash

# ----------------------------------
# Output
declare -A ModulesDisabled
declare -A Modules
declare ldr_mod_verbose=false


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

