#!/usr/bin/env bash


hdd_fdisk() {

	PARTED_COMMANDS="mklabel gpt \
		mkpart primary fat32 1MiB $(( 1 + EFI_SIZE ))MiB \
		name 1 uefi \
		set 1 esp on"

	if [[ $SWAP_SIZE == 0 ]]
	then
		echo "Skipping swap"
		NO_SWAP="no-swap"
		ROOT_PART=2
		ROOT_START="$(( 1 + EFI_SIZE ))MiB"
	else
		echo "Partitoning with ${SWAP_SIZE}MiB for swap and rest for root"
		PARTED_COMMANDS="$PARTED_COMMANDS \
			mkpart primary linux-swap $(( 1 + EFI_SIZE ))MiB $(( 1 + EFI_SIZE + SWAP_SIZE ))MiB \
			name 2 swap"
		ROOT_PART=3
		ROOT_START="$(( 1 + EFI_SIZE + SWAP_SIZE ))MiB"
	fi

	PARTED_COMMANDS="$PARTED_COMMANDS \
		mkpart primary ext4 $ROOT_START -0 \
		name $ROOT_PART root"

	unset ROOT_START

	# Only apply partitioning if not skipping debootstrap
	if [[ -z "$SKIP_DEBOOTSTRAP" ]]
	then
		vio_info "$PARTED_COMMANDS"
		parted -s -a optimal -- $NBD_DEV \
			$PARTED_COMMANDS
			
		unset PARTED_COMMANDS
	fi

	echo "Partitioned disk:"
	parted -s $NBD_DEV print
}


hdd_format() {
    # Only format if not skipping debootstrap
    if [[ -z "$SKIP_DEBOOTSTRAP" ]]
    then
	    echo "Formating:"
	    echo "...EFI partition"
	    peval mkfs -t fat -F 32 -n EFI ${NBD_DEV}p1
	    if [[ -z $NO_SWAP ]]
	    then
		    echo "...swap"
		    peval mkswap -L swap ${NBD_DEV}p2
	    fi
	    echo "...root"
	    peval mkfs -t ext4 -L root ${NBD_DEV}p${ROOT_PART}
    fi
    unset ROOT_PART
}


hdd_read_UUID() {
    ROOT_UUID="$(blkid | grep "^${NBD_DEV}p[0-9]\+:" | grep ' LABEL="root" ' | grep -o ' UUID="[^"]\+"' | sed -e 's/^ //' )"
    [[ -z $NO_SWAP ]] && SWAP_UUID="$(blkid | grep "^${NBD_DEV}p[0-9]\+:" | grep ' LABEL="swap" ' | grep -o ' UUID="[^"]\+"' | sed -e 's/^ //' )"
    EFI_UUID="$(blkid | grep "^${NBD_DEV}p[0-9]\+:" | grep ' LABEL="EFI" ' | grep -o ' UUID="[^"]\+"' | sed -e 's/^ //' )"

    vio_info "Root: $ROOT_UUID"
    [[ -z $NO_SWAP ]] && vio_info "swap: $SWAP_UUID"
    vio_info "EFI: $EFI_UUID"
}

