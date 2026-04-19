#!/bin/bash

ldr_insfile prepare.sh

ldr_insfile nbd.sh
ldr_insfile hdd.sh
ldr_insfile chroot.sh
ldr_insfile qemu.sh
ldr_insfile debootstrap.sh

ldr_insfile scripts.sh
