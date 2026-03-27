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
	  vio_print "${ERROR}[ERROR] No menu items provided${RESET}"
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
    vio_print
    vio_print "Choices Helper"
    vio_print
    vio_print "\t-h   | --help                : Show this help guide and quits"
    vio_print "\t-p   | --plugin              : Presenter plugin: menu(default) or rofi"
    vio_print "\t-o   | --options             : Menu options"
    vio_print "\t-l   | --labels              : Menu label options. displayed instead options when defined"
    vio_print "\t-i   | --index               : Set selected index. Default 0"
    vio_print "\t-vo  | --variable            : Set output variable name. Default 'selected'"
    vio_print "\t-tc  | --themecolor          : Set Color Theme"
    vio_print "\t-tcl | --themecolorlist      : Available Color Themes"
    vio_print "\t-ts  | --themeshape          : Set Shape Theme"
    vio_print "\t-tsl | --themeshapelist      : Available Shape Themes"
    vio_print "\t-T   | --title               : Set menu title"
    vio_print "\t-a   | --autoselect          : Return first option when is the unique option. Otherwise force confirm the selection"
    vio_print "\t-v   | --verbose             : Inspect internal variables for debug"
    vio_print
    vio_print "Keyboard usage"
    vio_print "\t<up> <down> : change option"
    vio_print "\t<enter>     : accept"
    vio_print "\t<right>     : change theme (colors)"
    vio_print "\t's'         : remember theme"
    vio_print "\t'q' <ESC>   : quit (cancel)"
    vio_print
}


# ----------------------------------- COLOR
choices_themecolor_list() {
  vio_print
  vio_print "Theme Color List"
  vio_print
  if [[ $( type -t menutheme_color_getNames ) ]]; then
      vio_print "\t${WARNING} $( menutheme_color_getNames ) ${RESET}"
  fi
  vio_print
} 

# ----------------------------------- SHAPE
choices_themeshape_list() {
  vio_print
  vio_print "Theme Shape List"
  vio_print
  if [[ $( type -t menutheme_shape_getNames ) ]]; then
      vio_print "\t${WARNING} $( menutheme_shape_getNames ) ${RESET}"
  fi
  vio_print
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
      vio_print
      vio_print "Menu Variables"
      vio_print -n "\t command line  : " 
      vio_print "$commandLine" 
      vio_print "\t plugin        : " "$plugin" 
      vio_print "\t theme         : " "$theme" 
      vio_print "\t shape         : " "$shape" 
      vio_print "\t inputName     : " "$inputName"
      vio_print "\t result        : " "$result"
      vio_print "\t selectedIndex : " "$selectedIndex"
      arrayTrace "menuItems"
      arrayTrace  "labelItems"
      arrayTrace "remainingArgs"
    fi
}

