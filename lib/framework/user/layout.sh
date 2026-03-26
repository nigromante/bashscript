#!/bin/bash

welcome() {
  banner
	header 
  title
}

banner() {
  if [[ "$APP_TITLE" != "" ]]; then
	    setColor "${GREEN}"
	    figlet -f big "${APP_TITLE}"
	    setColor "${RESET}"
  fi
}

header() {
  if [[ "$APP_AUTHOR" != "" ]]; then
	    fecha=$(date +"%Y-%m-%d %H:%M:%S")
	    print "${INFO}${APP_AUTHOR}  ...   ${WARNING}${fecha}${BR}${RESET}"
  fi
	resetColor
}

title() {
  if [[ "$APP_DESCRIPTION" != "" ]]; then
	    print "${INFO}${BR}${APP_DESCRIPTION}${BR}${RESET}"
  fi
}


bye() {
	print "${BRx2}Bye...${BR}"
}
