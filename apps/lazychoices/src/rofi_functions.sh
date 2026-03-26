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
    aopts_meses=("ene" "feb" "mar" "abr" "may" "jun" "jul" "ago" "sep" "oct" "nov" "dic")
    albls_meses=("enero" "febrero" "marzo" "abril" "mayo" "junio" "julio" "agosto" "septiembre" "octubre" "noviembre" "diciembre")

    choices -p $PRESENTER -o "aopts_meses" -l "albls_meses" -vo "salida" -T "Seleccione\x20Mes"

    echo "[${salida}]"
}

