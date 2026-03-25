#!/bin/bash

source ${LIBPATH}/_loader.sh

loader_manager() {
    moduleLoad framework/user
    moduleLoad sys
    moduleLoad menu
    moduleLoad utils
}


init() {
    setAuthor       "JULIAN VIDAL A"
    setTitle        "MPlayer Menu"
    setDescription  " --- W E B C A M ---  Test "
}


run() {

    mplayer_devices

    choices -o "mplayer_list" -vo "mplayer_device_selected" -T "Dispositivo\x20Webcam"

    if [[ "${mplayer_device_selected}" != "" ]]; then

        mplayer_play_webcam ${mplayer_device_selected}

    fi

}

loader_manager
start
