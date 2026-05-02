#!/bin/bash

source ${LIBPATH}/_loader.sh


loader_manager() {
    ldr_insmod framework/user
    ldr_insmod sys
    ldr_insmod dev
    ldr_insmod utils
}


begin() {
    app_setAuthor       "JULIAN VIDAL A"
    app_setTitle        "ffmpeg"
    app_setDescription  " --- CAPTURE VIDEO  --- "

    peval_theme_vision
    peval_mode_debug
}


run() {

  capture_video

}


loader_manager
start $@

