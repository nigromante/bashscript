#!/bin/bash

DEFAULT_SRC="/dev/sdb2"
DEFAULT_TARGET="/mnt/otherlinux"


getMediaDevice() {
  pp=$( mount -l | grep media | awk '{ print $1 }' )
  echo "$pp"
}


getMediaMount() {
  pp=$( mount -l | grep media | awk '{ print $3 }' )
  echo "$pp"
}


show_params() {
  echo -e "[[ $media ]]"
  echo -e "[[ $curdir ]]"
  echo -e "[[ $tools ]]"
  echo -e "[[ $src ]]"
  echo -e "[[ $target ]]"
}


mount_device() {

  curdir=$( sys_appWorkDir )
  tools="${curdir}/tools"

  if [ "$1" == "" ]; then
      src=$( getMediaDevice )
      media=$( getMediaMount )
  else
      src="$1"
  fi

  [[ -z $target ]] && target="$DEFAULT_TARGET"
  [[ -z $src    ]] && src="$DEFAULT_SRC"
  
  show_params

  # Mount Devices
  peval sudo  umount  $src
  peval sudo  mount  $src  ${target}

  for dev in /dev /dev/pts /proc /sys /run; do
    peval sudo mount --bind $dev  ${target}${dev}
  done


  # Mount tools folder
  if [ ! -e "$target" ]; then
    echo creating $target
    mkdir -p "$target/rescue"
  fi
  peval sudo mount --bind $tools  ${target}/mnt/rescue

  # Chroot
  peval  sudo  chroot  ${target}

}


umount_device() {

  peval sudo  umount -Rf   ${target}
  
}
