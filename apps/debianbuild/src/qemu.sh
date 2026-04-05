#!/usr/bin/env bash

qemu_create_image() {
    # Create image file, unless reusing an existing one
    if [[ -z "$SKIP_DEBOOTSTRAP" ]]
    then
	    echo "Creating image"
        peval qemu-img create -f qcow2 $FILE $SIZE
    else
	    if ! [[ -f $FILE ]]
	    then
		    echo "Cannot skip debootstrap if the image does not exist." >&2
		    exit 1
	    fi
    fi
}

qemu_nbd_mount() {
    echo "Mounting image on $NBD_DEV"
    peval qemu-nbd -c $NBD_DEV $FILE
}


qemu_nbd_umount() {
  if [[ -z $SKIP_UNMOUNT ]]
  then
	  echo "Disconnecting $NBD_DEV"
	  sync
	  peval qemu-nbd -d $NBD_DEV
  else
	  echo "WARNING: Unmount skipped (as requested)" >&2
	  echo "Multiple filesystems are mounted at and under /mnt, do not forget to unmount when finished."
	  echo "NBD is also still connected, disconnect (AFTER unmounting!) with: qemu-nbd -d $NBD_DEV"
  fi
}

qemu_run() {

  peval qemu-system-x86_64 \
  -m 2G \
  -smp 2 \
  -drive file=$FILE,format=qcow2 \
  -netdev user,id=net0,hostfwd=tcp::2222-:22 \
  -device e1000,netdev=net0 \
  -display default,show-cursor=on

}
