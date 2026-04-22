#!/usr/bin/env bash


make_main() {
    default_base_kernel="6"
    default_action="help"

    [[ "$1" != "" ]]  && action="$1" || action="$default_action"
    [[ "$2" != "" ]]  && base="$2"   || base="$default_base_kernel"

    make_env  "$base"

    case "$action" in

      "h" | "help")
        kernel_help
        ;;
      "i" | "info")
        make_info
        ;;
      "d" | "download")
        make_download
        ;;
      "r" | "repair")
        make_repair
        ;;
      "f" | "full")
        make_all
        ;;
      *)
        kernel_help

    esac
}


kernel_help(){
  clear
  vio_setColor $PURPLE &&   figlet "Kernel compiler tools" && vio_setColor $BLANK
  cat << EOF
  Usage:

  ezsdbg kernel/kernel.sh [action] [base_version]

  action:
    h | help     : This help screen.
    i | info     : Info about required version of kernel.
    d | download : Prepare working folder
                       download sources from kernel.org
                       unzip into  sources folder
                       copy current config from boot to sources folder
                   ... to contine, uses 'repair' option next time.
    r | repair   : Useful when needs change kernel config. Doesn't make downloads
                   niether copy config file.
                       edit config options
                       compile kernel
                       install packages
    f | full     : Create kernel from scratch, full proccess.



    Examples:

      ezsdbg kernel/kernel.sh info 7

      ezsdbg kernel/kernel.sh create 7
      
      ezsdbg kernel/kernel.sh repair 7

EOF
}


