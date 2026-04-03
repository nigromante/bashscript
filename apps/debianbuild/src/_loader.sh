#!/bin/bash

moduleLoadFile build_entry.sh
moduleLoadFile prepare.sh

moduleLoadFile nbd.sh
moduleLoadFile hdd.sh
moduleLoadFile chroot.sh
moduleLoadFile debootstrap.sh

moduleLoadFile scripts.sh
