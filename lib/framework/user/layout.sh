#!/bin/bash

layout_welcome() {
  layout_banner
	layout_header 
  layout_title
}

layout_banner() {
  if [[ "$APP_TITLE" != "" ]]; then
	    vio_setColor "${GREEN}"
	    figlet -f big "${APP_TITLE}"
	    vio_resetColor
  fi
}

layout_header() {
  if [[ "$APP_AUTHOR" != "" ]]; then
	    fecha=$(date +"%Y-%m-%d %H:%M:%S")
	    vio_print "${INFO}${APP_AUTHOR}  ...   ${WARNING}${fecha}${BR}"
    	vio_resetColor
  fi
}

layout_title() {
  if [[ "$APP_DESCRIPTION" != "" ]]; then
	    vio_print "${INFO}${BR}${APP_DESCRIPTION}${BR}"
    	vio_resetColor
  fi
}
