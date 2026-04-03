#!/usr/bin/env bash



chroot_mount() {
    echo "Mounting for chroot"
    mount $ROOT_UUID /mnt
    [[ -d /mnt/boot/efi ]] || mkdir -p /mnt/boot/efi
    mount $EFI_UUID /mnt/boot/efi
}

chroot_mount_system() {
    echo "Mounting proc, dev and sys"
    mount -o bind,ro /dev /mnt/dev
    mount -t proc none /mnt/proc
    mount -t sysfs none /mnt/sys
}

chroot_umount() {

  if [[ -z $SKIP_UNMOUNT ]]
  then
	  echo "Unmounting chroot"
	  umount /mnt/dev /mnt/proc /mnt/sys /mnt/boot/efi /mnt
  else
	  echo "WARNING: Unmount skipped (as requested)" >&2
	  echo "Multiple filesystems are mounted at and under /mnt, do not forget to unmount when finished."
	  echo "NBD is also still connected, disconnect (AFTER unmounting!) with: qemu-nbd -d $NBD_DEV"
  fi

}


