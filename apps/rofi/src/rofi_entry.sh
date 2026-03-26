#!/bin/bash

begin() {
    setAuthor       "JULIAN VIDAL A"
    setTitle        "MPlayer Menu"
    setDescription  " --- W E B C A M ---  Test "
}


run() {

    mplayer_devices
    choices -o "mplayer_list" -vo "mplayer_device_selected" -T "Dispositivo\x20Webcam"
    if [[ "${mplayer_device_selected}" != "" ]]; then
        echo "[${mplayer_device_selected}]"
        mplayer_play_webcam ${mplayer_device_selected}
    fi


    choices -o "meses_opts" -l "meses_opts" -vo "salida" -T "Seleccione\x20Mes"

    echo "[${salida}]"

}

