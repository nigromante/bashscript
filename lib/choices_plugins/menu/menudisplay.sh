#!/bin/bash



normalizeList() {
  size=$( array_getSize "$1" )
  length=$( array_getLongest "$1" )
  titlength="${#2}"
  if [[ $length < $titlength ]]; then
    length=$(( $titlength - 12 ))
  fi

  spaces=$(printf ' %.0s' $(eval "echo {1.."$(($length))"}"))
	local arr=$1[@]
	arr=("${!arr}")

  narr=()
  for(( i=0 ; i < $size ; i++ )); do
    currItem="${arr[$i]}"
	  currItemLength=${#currItem}
	  currItem=" ${spaces:0:0}${currItem}${spaces:currItemLength} "
    narr+=("$currItem")
  done
}

menudisplay_prepare() {

    titulo="${BORDER}${UP_LEFT}----------${TITULO_LEFT}${TEXT_TITLE} ${title} ${BORDER}${TITULO_RIGHT}----------${UP_RIGHT}"
    titulo2="${BORDER}----------${TITULO_LEFT}${TEXT_TITLE} ${title} ${BORDER}${TITULO_RIGHT}----------"
    
    titulo2=$(unescape "$titulo2")
    bottom="$(mklinea "$titulo2")"

    titulo="$(strreplace "$titulo" "-" "${HORIZONTAL}")"
    bottom="$(strreplace "$bottom" "-" "${HORIZONTAL}")"

    if [[ 0 -lt $labelsLength ]]; then
      normalizeList "labelItems" "$titulo2"
    else
      normalizeList "menuItems" "$titulo2"
    fi
    menudisplay_titulo="$titulo"
    menudisplay_bottom="$bottom"
}


menudisplay_layout(){

    if [[ $verbose == true ]]; then 
      vio_print "${menudisplay_titulo} ${LIGHTGRAY}(${theme}/${shape})              "
    else
      vio_print "${menudisplay_titulo}"
    fi

    menudisplay_pagedown

    vio_print "${BORDER}${BOTTOM_LEFT}${menudisplay_bottom}${BOTTOM_RIGHT}${RESET}"

    menudisplay_pageup 1
}


menudisplay_content() {

    for (( i=0 ; i < $itemsLength ; i++ )); do
        
        currItem="${narr[$i]}"

        if [[ $i == $selectedIndex ]]; then
            vio_print "${BORDER}${VERTICAL_SELECT}${ICON_SELECTED}  ${MARK}  ${TEXT_SELECTED} ${currItem} ${BORDER}${VERTICAL_SELECT}${RESET}"
        else
            vio_print "${BORDER}${VERTICAL}     ${TEXT_NORMAL} ${currItem} ${BORDER}${VERTICAL}${RESET}"
        fi

    done 

    menudisplay_pageup 0
}

menudisplay_cursor_up() {
    vio_upLine "1"   # deb subir 1 linea al titulo
}

menudisplay_pageup() {
    height=$(( $itemsLength + $1 ))
    vio_upLine "${height}"
}

menudisplay_pagedown() {
    for(( i=0 ; i < $itemsLength ; i++ )); do
      echo ""
    done
}


