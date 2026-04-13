#!/bin/bash

moduleLoadFile prepare.sh

moduleLoadFile nbd.sh
moduleLoadFile hdd.sh
moduleLoadFile chroot.sh
moduleLoadFile qemu.sh
moduleLoadFile debootstrap.sh

moduleLoadFile scripts.sh
