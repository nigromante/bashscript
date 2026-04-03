#!/bin/bash

moduleLoadFile prepare.sh

moduleLoadFile nbd.sh
moduleLoadFile hdd.sh
moduleLoadFile chroot.sh
moduleLoadFile debootstrap.sh

moduleLoadFile scripts.sh
