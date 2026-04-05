#!/usr/bin/env bash


nbd_check_support() {
    echo "Checking for nbd support"
    if ! lsmod | grep -q '^nbd\s'
    then
	    echo "Probing module"
	    peval modprobe nbd
    fi


    if ! [[ -e $NBD_DEV ]]
    then
	    echo "Sanity check for $NBD_DEV failed. Aborting." >&2
	    exit 1
    fi
}


