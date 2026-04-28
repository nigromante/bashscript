#!/bin/bash

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod framework/root
    ldr_insmod sys
    ldr_insmod dev
    ldr_insmod utils
    ldr_insmod_local src
}


mount_usage() {
	cat - <<EOF

	Usage: ezsdbg  qemu/mount.sh [-h] [-w workdir] [-f file]

  arguments:
      -h          : Help
      -f file     : Filename for the image, without extension. Defaults ( uname -n )
      -w workdir  : Folder where images lies. Defaults ( . )

EOF
}


mount_proc_args() {
	while getopts "f:w:h" opt;
	do
		case $opt in
			h )
				mount_usage
				exit 0
				;; 
      w )
        WORKDIR="$OPTARG"
        ;;
			f )
				FILE="$OPTARG"
				;;
			* )
				mount_usage
				exit 1
				;;
		esac
	done

  NAME="$( uname -n )"
	[[ -z $FILE ]] && FILE="$NAME"
	[[ -z $WORKDIR ]] && WORKDIR="."
}


mount_resume_values() {
    echo "file                 : $FILE" 
    echo "work dir             : $WORKDIR"
}

begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "Debian VM debootstrap"
    app_setDescription  " --- MOUNT IMAGE --- "

    mount_proc_args $@

    peval_theme_vision
    peval_mode_debug
}


run() {
    mount_resume_values

    nbd_check_support
    qemu_nbd_mount
    hdd_read_UUID
    chroot_mount
    chroot_mount_system
}


loader_manager
start $@
