#!/bin/bash

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


    aopts_meses=("ene" "feb" "mar" "abr" "may" "jun" "jul" "ago" "sep" "oct" "nov" "dic")
    albls_meses=("enero" "febrero" "marzo" "abril" "mayo" "junio" "julio" "agosto" "septiembre" "octubre" "noviembre" "diciembre")

    choices -o "aopts_meses" -l "albls_meses" -vo "salida" -T "Seleccione\x20Mes"

    echo "[${salida}]"

}

