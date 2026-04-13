#!/usr/bin/env bash

debootrap_run() {
    # The main debootstrap - skip if requested
    if [[ -z "$SKIP_DEBOOTSTRAP" ]]
    then
	    echo "Bootstrapping debian"
	    # XXX Hardcoded to x86_64 architecture but at the moment I do not want to run anything else.
	    # debootstrap --arch amd64 --include=salt-minion $SUITE /mnt http://ftp.uk.debian.org/debian
	    debootstrap --arch amd64 $SUITE /mnt 
    fi
}
