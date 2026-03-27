#!/bin/bash

PRESENTER="menu"

begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "MPlayer Menu"
    app_setDescription  " --- W E B C A M ---  Test "
}


run() {

    mplayer_devices

    choices -p $PRESENTER -o "mplayer_list" -vo "mplayer_device_selected" -T "Dispositivo\x20Webcam"

    if [[ "${mplayer_device_selected}" != "" ]]; then

        mplayer_play_webcam ${mplayer_device_selected}

    fi

}

