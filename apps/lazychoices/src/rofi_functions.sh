#!/bin/bash

PRESENTER="menu"

info() {
    # moduleVerbose

    moduleAppName
    moduleList 
    moduleDisabledList

    moduleSilent
}


webcam() {

    mplayer_devices
    choices -p $PRESENTER -o "mplayer_list" -vo "mplayer_device_selected" -T "Dispositivo\x20Webcam"
    if [[ "${mplayer_device_selected}" != "" ]]; then
        echo "[${mplayer_device_selected}]"
        # mplayer_play_webcam ${mplayer_device_selected}
    fi
}


meses() {

    choices -p $PRESENTER -o "meses_opts" -l "meses_lbls" -vo "salida" -T "Seleccione\x20Mes"

    echo "[${salida}]"
}

