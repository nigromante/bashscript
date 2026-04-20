#!/bin/bash

# ----------------------------------
# Colors
# ----------------------------------
RESET="\033[0m"
NOCOLOR='\033[0m'
RED='\033[0;31m'
GREEN='\033[0;32m'
ORANGE='\033[0;33m'
BLUE='\033[0;34m'
PURPLE='\033[0;35m'
CYAN='\033[0;36m'
LIGHTGRAY='\033[0;37m'
DARKGRAY='\033[1;30m'
LIGHTRED='\033[1;31m'
LIGHTGREEN='\033[1;32m'
DARKGREEN='\033[0;32m'
YELLOW='\033[1;33m'
LIGHTBLUE='\033[1;34m'
LIGHTPURPLE='\033[1;35m'
LIGHTCYAN='\033[1;36m'
WHITE='\033[1;37m'

# ----------------------------------
# Colors
# ----------------------------------
ERROR="${RED}"
SUCCESS=${GREEN}
WARNING=${YELLOW}
INFO=${PURPLE}
BLANK=${RESET}

# ----------------------------------
# Output
# ----------------------------------
TAB=$'\t'
TABx2=$'\t\t'
TABx3=$'\t\t\t'
TABx4=$'\t\t\t\t'

BR=$'\n'
BRx2=$'\n\n'
BRx3=$'\n\n\n'
BRx4=$'\n\n\n\n'

# ----------------------------------
# Keys
# ----------------------------------
K_F1=$'\e[11~'
K_F2=$'\e[12~' 
K_F3=$'\e[13~' 
K_F4=$'\e[14~' 
K_F5=$'\e[15~'
K_F6=$'\e[16~'
K_F7=$'\e[17~'
K_F8=$'\e[18~'
K_F9=$'\e[19~'
K_F10=$'\e[20'
K_F11=$'\e[21'
K_F12=$'\e[22'
K_UP=$'\e[A'
K_DOWN=$'\e[B'
K_RIGHT=$'\e[C'
K_LEFT=$'\e[D'
K_TAB=$'\t~'
K_DEL=$'\e[3~'
K_ENTER=$(echo -e "\n")
K_ESC=$(printf "\033")

# ----------------------------------
# Cursor
# ----------------------------------
CURSOR_HIDE="\033[?25l"
CURSOR_SHOW="\033[?25h"
