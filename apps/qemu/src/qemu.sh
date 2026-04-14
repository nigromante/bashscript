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

    VM="${WORKDIR}/${FULLNAME}"

    if ! test -e "$VM.varstore"; then
      peval  cp /usr/share/OVMF/OVMF_VARS_4M.fd "$VM.varstore"
    fi

    if ! test -e "$VM.qcow2"; then
      echo "${VM}.qcow2 :: no existe !!! "
      return
    fi

    peval   qemu-system-x86_64 \
      -enable-kvm \
      -cpu host \
      -m 2G \
      -smp 2 \
      -drive if=pflash,unit=0,format=raw,file=/usr/share/OVMF/OVMF_CODE_4M.fd \
      -drive if=pflash,unit=1,format=raw,file="$VM.varstore" \
      -boot menu=on,splash-time=3000 \
      -drive id=disk,if=none,format=qcow2,file="$VM.qcow2"  \
      -device ide-hd,bus=ide.0,unit=0,drive=disk,bootindex=1 
      
      #\
      #-net nic,model=virtio -net user \
      #-netdev bridge,id=hn1,br=br0 \
      #-device virtio-net,netdev=hn1,mac=e6:c8:ff:09:76:99 


}
