#!/bin/bash


# ------------------------------------ MAIN
choices() {
  choices_args_trace $@
  choices_args $@
  choices_info
  if [[ "${ret}" == "true" ]]; then
    choices_run
  fi
}

# -------------------------------TRACE ARGS
choices_args_trace() {
  commandLine="choices $@"
}

# ------------------------------------ ARGS
choices_args() {
  shape=""
  theme=""
  plugin="menu"
  title="Seleccionar ..."
	displayHelp=false
  autoSelect=false
  verbose=false
	themecolorlist=false
	themeshapelist=false
	selectedIndex=0
  result="selected"
  inputName=""
  menuItems=()
  labelItems=()
	remainingArgs=()

	while [[ $# -gt 0 ]]; do
		local key="$1"

		case $key in
			-h|--help)
				displayHelp=true
				shift
				;;

      -p|plugin)
        plugin="$2"
        shift 2
        ;;
      -a|--autoselect)
        autoSelect=true
        shift
        ;;

      -v|--verbose)
        verbose=true
        shift
        ;;

			-T|--title)
				title=$2
				shift 2
				;;

			-tc|--themecolor)
				theme=$2
				shift 2
				;;

			-tcl|--themecolorlist)
				themecolorlist=true
				shift 1
				;;

			-ts|--themeshape)
				shape=$2
				shift 2
				;;

			-tsl|--themeshapelist)
				themeshapelist=true
				shift 1
				;;


			-i|--index)
				selectedIndex=$2
				shift 2
				;;

			-o|--options)
        inputName=$2
				menuItems=$2[@]
				menuItems=("${!menuItems}")
				shift 2
				;;

			-l|--labels)
				labelItems=$2[@]
				labelItems=("${!labelItems}")
				shift 2
				;;

			 -vo|--variable)
				result=$2
				shift 2
				;;

			*)
				remainingArgs+=("$1")
				shift
				;;
		esac
	done

	itemsLength=${#menuItems[@]}
  labelsLength="${#labelItems[@]}"
    
  # clean output variable
  printf -v "${result}" ""
  printf -v "ret" "false"

  if [[ $displayHelp == true ]]; then 
	    choices_help 
      return
  fi

  if [[ $themecolorlist == true ]]; then 
	    choices_themecolor_list 
      return
  fi

  if [[ $themeshapelist == true ]]; then 
	    choices_themeshape_list 
      return
  fi

  if [[ $itemsLength -lt 1 ]]; then
	  echo -e "${ERROR}[ERROR] No menu items provided${RESET}"
    return
  fi

  if [[ $autoSelect == true && $itemsLength -eq 1 ]]; then
    printf -v "${result}" "${menuItems[0]}"
    return
  fi

  printf -v "ret" "true"
}


# ------------------------------------ HELP
choices_help() {
    echo
    echo "Choices Helper"
    echo
    echo -e "\t-h   | --help                : Show this help guide and quits"
    echo -e "\t-p   | --plugin              : Presenter plugin: menu(default) or rofi"
    echo -e "\t-o   | --options             : Menu options"
    echo -e "\t-l   | --labels              : Menu label options. displayed instead options when defined"
    echo -e "\t-i   | --index               : Set selected index. Default 0"
    echo -e "\t-vo  | --variable            : Set output variable name. Default 'selected'"
    echo -e "\t-tc  | --themecolor          : Set Color Theme"
    echo -e "\t-tcl | --themecolorlist      : Available Color Themes"
    echo -e "\t-ts  | --themeshape          : Set Shape Theme"
    echo -e "\t-tsl | --themeshapelist      : Available Shape Themes"
    echo -e "\t-T   | --title               : Set menu title"
    echo -e "\t-a   | --autoselect          : Return first option when is the unique option. Otherwise force confirm the selection"
    echo -e "\t-v   | --verbose             : Inspect internal variables for debug"
    echo
    echo -e "Keyboard usage"
    echo -e "\t<up> <down> : change option"
    echo -e "\t<enter>     : accept"
    echo -e "\t<right>     : change theme (colors)"
    echo -e "\t's'         : remember theme"
    echo -e "\t'q' <ESC>   : quit (cancel)"
    echo
}


# ----------------------------------- COLOR
choices_themecolor_list() {
  echo
  echo "Theme Color List"
  echo
  echo -e "\t${WARNING} $( menutheme_color_getNames ) ${RESET}"
  echo
} 

# ----------------------------------- SHAPE
choices_themeshape_list() {
  echo
  echo "Theme Shape List"
  echo
  echo -e "\t${WARNING} $( menutheme_shape_getNames ) ${RESET}"
  echo
} 

# ------------------------------------- RUN
choices_run() {

    moduleLoad "lazy_${plugin}"
    choices_menu_loader
    choices_menu_run
}

# ------------------------------------ INFO
choices_info() {

    if [[ $verbose == true ]]; then 
      echo
      echo -e "Menu Variables"
      echo -e -n "\t command line  : " ; echo "$commandLine" 
      echo -e "\t plugin        : " "$plugin" 
      echo -e "\t theme         : " "$theme" 
      echo -e "\t shape         : " "$shape" 
      echo -e "\t inputName     : " "$inputName"
      echo -e "\t result        : " "$result"
      echo -e "\t selectedIndex : " "$selectedIndex"
      arrayTrace "menuItems"
      arrayTrace  "labelItems"
      arrayTrace "remainingArgs"
    fi
}

