#!/bin/bash

# usage :   linea=$(unescape "$texto")
unescape() {
    local patron1='s/\\[0-9]*\[[0-9]*\m//g'
    local patron2='s/\\[0-9]*\[[0-9]*;[0-9]*\m//g'
    local linea="$( echo "$1" | sed -e $patron1 | sed -e $patron2 )"
    echo "$linea"
}

mklinea() {
    local patron0='s/\\x20/-/g'
    local patron1='s/[a-z]/-/g'
    local patron2='s/[A-Z]/-/g'
    local patron3='s/[0-9]/-/g'
    local patron4='s/\s/-/g'
    local patron5='s/./-/g'
    local linea="$( echo "$1" | sed -e $patron0 | sed -e $patron1 | sed -e $patron2 | sed -e $patron3 | sed -e $patron4 | sed -e $patron5 )"
    echo "$linea"
}
