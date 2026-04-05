#!/usr/bin/env bash



chroot_mount() {
    echo "Mounting for chroot"
    peval mount $ROOT_UUID /mnt
    [[ -d /mnt/boot/efi ]] || peval mkdir -p /mnt/boot/efi
    peval mount $EFI_UUID /mnt/boot/efi
}

chroot_mount_system() {
    echo "Mounting proc, dev and sys"
    # peval mount -o bind,ro /dev /mnt/dev
    # peval mount -t proc none /mnt/proc
    # peval mount -t sysfs none /mnt/sys
    for i in /dev /dev/pts /proc /sys /sys/firmware/efi/efivars /run; do sudo mount -B $i /mnt$i; done
}

chroot_umount() {

  if [[ -z $SKIP_UNMOUNT ]]
  then
	  echo "Unmounting chroot"
	  # peval umount /mnt/dev /mnt/proc /mnt/sys /mnt/boot/efi /mnt
	  peval umount -R /mnt
  else
	  echo "WARNING: Unmount skipped (as requested)" >&2
	  echo "Multiple filesystems are mounted at and under /mnt, do not forget to unmount when finished."
	  echo "NBD is also still connected, disconnect (AFTER unmounting!)"
  fi

}


