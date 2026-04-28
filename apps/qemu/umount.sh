#!/bin/bash

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod framework/root
    ldr_insmod sys
    ldr_insmod dev
    ldr_insmod utils
    ldr_insmod_local src
}


umount_usage() {
	cat - <<EOF

	Usage: ezsdbg  qemu/umount.sh [-h] [-w workdir] [-f file]

  arguments:
      -h          : Help
      -f file     : Filename for the image, without extension. Defaults ( uname -n )
      -w workdir  : Folder where images lies. Defaults ( . )

EOF
}


umount_proc_args() {
	while getopts "f:w:h" opt;
	do
		case $opt in
			h )
				umount_usage
				exit 0
				;; 
      w )
        WORKDIR="$OPTARG"
        ;;
			f )
				FILE="$OPTARG"
				;;
			* )
				umount_usage
				exit 1
				;;
		esac
	done

  NAME="$( uname -n )"
	[[ -z $FILE ]] && FILE="$NAME"
	[[ -z $WORKDIR ]] && WORKDIR="."
}


umount_resume_values() {
    echo "file                 : $FILE" 
    echo "work dir             : $WORKDIR"
}


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Debian VM debootstrap"
    app_setDescription  " --- UMOUNT IMAGE --- "

    umount_proc_args $@

    peval_theme_vision
    peval_mode_debug
}


run() {
    umount_resume_values

    nbd_check_support
    chroot_umount
    qemu_nbd_umount
}


loader_manager
start $@

