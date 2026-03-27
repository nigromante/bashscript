#!/bin/bash

layout_welcome() {
  layout_banner
	layout_header 
  layout_title
}

layout_banner() {
  if [[ "$APP_TITLE" != "" ]]; then
	    setColor "${GREEN}"
	    figlet -f big "${APP_TITLE}"
	    resetColor
  fi
}

layout_header() {
  if [[ "$APP_AUTHOR" != "" ]]; then
	    fecha=$(date +"%Y-%m-%d %H:%M:%S")
	    vio_echo "${INFO}${APP_AUTHOR}  ...   ${WARNING}${fecha}${BR}"
    	resetColor
  fi
}

layout_title() {
  if [[ "$APP_DESCRIPTION" != "" ]]; then
	    vio_echo "${INFO}${BR}${APP_DESCRIPTION}${BR}"
    	resetColor
  fi
}
