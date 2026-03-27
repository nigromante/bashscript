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
	  vio_echo "${ERROR}[ERROR] No menu items provided${RESET}"
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
    vio_echo
    vio_echo "Choices Helper"
    vio_echo
    vio_echo "\t-h   | --help                : Show this help guide and quits"
    vio_echo "\t-p   | --plugin              : Presenter plugin: menu(default) or rofi"
    vio_echo "\t-o   | --options             : Menu options"
    vio_echo "\t-l   | --labels              : Menu label options. displayed instead options when defined"
    vio_echo "\t-i   | --index               : Set selected index. Default 0"
    vio_echo "\t-vo  | --variable            : Set output variable name. Default 'selected'"
    vio_echo "\t-tc  | --themecolor          : Set Color Theme"
    vio_echo "\t-tcl | --themecolorlist      : Available Color Themes"
    vio_echo "\t-ts  | --themeshape          : Set Shape Theme"
    vio_echo "\t-tsl | --themeshapelist      : Available Shape Themes"
    vio_echo "\t-T   | --title               : Set menu title"
    vio_echo "\t-a   | --autoselect          : Return first option when is the unique option. Otherwise force confirm the selection"
    vio_echo "\t-v   | --verbose             : Inspect internal variables for debug"
    vio_echo
    vio_echo "Keyboard usage"
    vio_echo "\t<up> <down> : change option"
    vio_echo "\t<enter>     : accept"
    vio_echo "\t<right>     : change theme (colors)"
    vio_echo "\t's'         : remember theme"
    vio_echo "\t'q' <ESC>   : quit (cancel)"
    vio_echo
}


# ----------------------------------- COLOR
choices_themecolor_list() {
  vio_echo
  vio_echo "Theme Color List"
  vio_echo
  if [[ $( type -t menutheme_color_getNames ) ]]; then
      vio_echo "\t${WARNING} $( menutheme_color_getNames ) ${RESET}"
  fi
  vio_echo
} 

# ----------------------------------- SHAPE
choices_themeshape_list() {
  vio_echo
  vio_echo "Theme Shape List"
  vio_echo
  if [[ $( type -t menutheme_shape_getNames ) ]]; then
      vio_echo "\t${WARNING} $( menutheme_shape_getNames ) ${RESET}"
  fi
  vio_echo
} 

# ------------------------------------- RUN
choices_run() {
    moduleLoadLazy "choices_plugins/${plugin}"
    eval "${plugin}_menu_loader"
    eval "${plugin}_menu_run"
}

# ------------------------------------ INFO
choices_info() {

    if [[ $verbose == true ]]; then 
      vio_echo
      vio_echo "Menu Variables"
      vio_echo -n "\t command line  : " 
      vio_echo "$commandLine" 
      vio_echo "\t plugin        : " "$plugin" 
      vio_echo "\t theme         : " "$theme" 
      vio_echo "\t shape         : " "$shape" 
      vio_echo "\t inputName     : " "$inputName"
      vio_echo "\t result        : " "$result"
      vio_echo "\t selectedIndex : " "$selectedIndex"
      arrayTrace "menuItems"
      arrayTrace  "labelItems"
      arrayTrace "remainingArgs"
    fi
}

