#!/bin/bash

init() {
    setAuthor       "JULIAN VIDAL A"
    setTitle        "MPlayer Menu"
    setDescription  " --- W E B C A M ---  Test "
}


webcam() {

    mplayer_devices
    choices -v -p "menu" -o "mplayer_list" -vo "mplayer_device_selected" -T "Dispositivo\x20Webcam"
    if [[ "${mplayer_device_selected}" != "" ]]; then
        echo "[${mplayer_device_selected}]"
        mplayer_play_webcam ${mplayer_device_selected}
    fi
}

meses() {
    aopts_meses=("ene" "feb" "mar" "abr" "may" "jun" "jul" "ago" "sep" "oct" "nov" "dic")
    albls_meses=("enero" "febrero" "marzo" "abril" "mayo" "junio" "julio" "agosto" "septiembre" "octubre" "noviembre" "diciembre")

    choices -v -o "aopts_meses" -l "albls_meses" -vo "salida" -T "Seleccione\x20Mes"

    echo "[${salida}]"
}

run() {

    meses

    webcam

    moduleVerbose
    moduleList 
    # moduleListFunctions

}

