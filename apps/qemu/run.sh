#!/bin/bash

## Usage:
#
#       sudo ../../launch/run.sh ./run.sh  -f ../../tmp/debian.qcow2
#

source ${LIBPATH}/_loader.sh


loader_manager() { 
    ldr_insmod framework/root
    ldr_insmod sys
    ldr_insmod dev
    ldr_insmod utils
    ldr_insmod_local src
}


run_usage() {
	cat - <<EOF

	Usage: ezsdbg  qemu/run.sh [h] [-w workdir] [-f file]

  -f file:    filename for the image, without extension. Defaults ( uname -n )
  -w workdir: Folder where images lies. Defaults ( . )

EOF
}


run_proc_args() {
	while getopts "f:w:h" opt;
	do
		case $opt in
			h )
				run_usage
				exit 0
				;; 
      w )
        WORKDIR="$OPTARG"
        ;;
			f )
				FILE="$OPTARG"
				;;
			* )
				run_usage
				exit 1
				;;
		esac
	done

  NAME="$( uname -n )"
	[[ -z $FILE ]] && FILE="$NAME"
	[[ -z $WORKDIR ]] && WORKDIR="."
}


resume_values() {
    echo "file                 : $FILE" 
    echo "work dir             : $WORKDIR"
}


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Debian VM debootstrap"
    app_setDescription  " --- RUN DEBIAN IMAGE --- "

    run_proc_args $@

    peval_theme_vision
    peval_mode_debug
}


run() {
    resume_values
    qemu_run
}


loader_manager
start $@

