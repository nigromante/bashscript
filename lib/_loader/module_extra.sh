#!/bin/bash


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

