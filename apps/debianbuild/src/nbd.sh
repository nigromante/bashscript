#!/usr/bin/env bash


nbd_check_support() {
    echo "Checking for nbd support"
    if ! lsmod | grep -q '^nbd\s'
    then
	    echo "Probing module"
	    modprobe nbd
    fi


    if ! [[ -e $NBD_DEV ]]
    then
	    echo "Sanity check for $NBD_DEV failed. Aborting." >&2
	    exit 1
    fi
}


nbd_mount() {
    echo "Mounting image on $NBD_DEV"
    cmd="qemu-nbd -c $NBD_DEV $FILE"
    echo -e "${YELLOW}[${PURPLE}$cmd${YELLOW}]${RESET}"
    eval $cmd
}


nbd_umount() {
  if [[ -z $SKIP_UNMOUNT ]]
  then
	  echo "Disconnecting $NBD_DEV"
	  sync
	  qemu-nbd -d $NBD_DEV
  else
	  echo "WARNING: Unmount skipped (as requested)" >&2
	  echo "Multiple filesystems are mounted at and under /mnt, do not forget to unmount when finished."
	  echo "NBD is also still connected, disconnect (AFTER unmounting!) with: qemu-nbd -d $NBD_DEV"
  fi
}
