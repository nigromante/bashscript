#!/usr/bin/env bash

TMP_PATH="."

make_set_tmp() {
  TMP_PATH="$1"
}


make_env() {
    machineName="$( uname -n )"
    DLOAD_PATH="${TMP_PATH}/dload"
    SOURCES_PATH="${TMP_PATH}/sources"
    VERSION_BASE="$1"
    VERSION="v${VERSION_BASE}.x"
    [[ "$1" == "7" ]] &&  FILTER="linux-${VERSION_BASE}\.[0-9]*\.tar\.xz" ||  FILTER="linux-${VERSION_BASE}\.[0-9]*\.[0-9]*\.tar\.xz"
    # FILTER="linux-${VERSION_BASE}\.[0-9]*\.[0-9]*\.tar\.xz"
    URL="https://www.kernel.org/pub/linux/kernel/${VERSION}"
    workpath=$(realpath "$0")
    workpath=$(dirname "$workpath")
}


make_getinfo() {
    LATEST="$( wget -qO- ${URL}/ | grep -o ${FILTER} | sort -V | tail -1 )"
    folder=$( echo "${LATEST/.tar.xz/}"  )
}


make_getinfo_local() {
    LATEST="$( wget -qO- ${URL}/ | grep -o ${FILTER} | sort -V | tail -1 )"
    folder=$( echo "${LATEST/.tar.xz/}"  )
}


xecho() {
    title=$1
    shift
    echo -e "${title:0:20} ${INFO}[${WARNING} $@ ${INFO}]${BLANK}"
}



make_show_info() {
  
    vio_setColor $PURPLE &&   figlet "Kernel ${VERSION}" && vio_setColor $BLANK

    xecho "machine             " ${machineName} 
    xecho "kernel.org          " ${URL} 
    xecho "Base version        " $VERSION " ( ${FILTER} )"
    xecho "Latest Linux source " $LATEST
    xecho "Linux folder        " $folder
    xecho "Scripts folder      " $workpath
    xecho "Processors          " $( nproc )
    xecho "Work folder         " $(pwd) 
}


make_download() {

    [[ ! -e "${DLOAD_PATH}/$latest" ]]   &&  wget -P ${DLOAD_PATH} ${URL}/${latest}
    [[ ! -e "${SOURCES_PATH}" ]] &&  tar -xvf "${DLOAD_PATH}/$latest" -C ${SOURCES_PATH}
}


make_go_sources() {
    cd "${SOURCES_PATH}/${folder}" 
    xecho "Linux folder        " $(pwd) 
    echo
}


make_get_config() {
    last=$( ls /boot/config-${VERSION_BASE}.* | sort -V | tail -1 )
    cp $last .config

    make olddefconfig
    make localmodconfig
}


make_config() {
    make menuconfig

    fecha=$(date +"%Y-%m-%d_%H:%M:%S") 
    cp .config "${TMP_PATH}/configs/config-$fecha"

    #### Reseting certs
    ./scripts/config --set-str SYSTEM_TRUSTED_KEYS ""
    ./scripts/config --set-str SYSTEM_REVOCATION_KEYS ""
}


make_clean() {
    make clean
}

make_build() {
    make -j$(nproc) bindeb-pkg LOCALVERSION=-$machineName 
}


make_install() {
    ### Install
    # sudo make modules_install
    # sudo make install
    echo ""
}


make_post_install() {
    ### Update grub
    # sudo update-grub
    echo ""
}



make_info() {
    make_getinfo
    make_show_info
    make_go_sources
}


make_all() {
    make_getinfo
    make_show_info
    make_download
    make_go_sources
    make_get_config
    make_config
    make_clean
    make_build
    make_install
    make_post_install
}


make_repair() {
    make_getinfo_local
    make_show_info
    make_go_sources
    make_config
    make_build
    make_install
    make_post_install
}





