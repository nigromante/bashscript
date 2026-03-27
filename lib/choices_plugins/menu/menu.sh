#!/bin/bash


# --------------------------------- NOVE UP
menu_move_up() {
    selectedIndex=$((selectedIndex-1))
    (( $selectedIndex < 0 )) && selectedIndex=$((itemsLength-1))
    menu_content
}

# ------------------------------- MOVE DOWN
menu_move_down() {
    selectedIndex=$((selectedIndex+1))
    (( $selectedIndex == $itemsLength )) && selectedIndex=0
    menu_content
}


# ----------------------------- MENU ESCAPE
menu_escape() {
    printf -v "${result}" ""
}

# ---------------- SET SELECTED ITEM OUTPUT
menu_select() {
    printf -v "${result}" "${menuItems[selectedIndex]}"
}


# ---------------------- SWITCH THEME SHAPE
menu_switch_theme_shape() {
    menutheme_shape_switch
    menu_cursor_up
    menu_prepare
}

# ---------------------- SWITCH THEME COLOR
menu_switch_theme_color() {
    menutheme_color_switch
    menu_cursor_up
    menu_prepare
}

# ------------------------------- MENU LOAD 
menu_load_theme() {
    menutheme_color_read
    menutheme_shape_read
}

# ------------------------------ SAVE THEME
menu_save_theme() {
    menutheme_color_write
    menutheme_shape_write
}

# ------------------------------- MENU INIT
menu_init() {
    trap_hideCursor
    menu_prepare
}

# --------------------------- END MENU MAIN
menu_end(){
    menu_pagedown
    trap_showCursor
}

# ------------------------ MANAGE ERROR KEY
menu_iddle() {
    echo -n ''
}

# ------------------------- MENU MAIN ENTRY
menu() {
    menu_init
    loopFlag=true
    while $loopFlag ; do
        kbd_readKey _key
        case $_key in
            $K_ENTER      ) menu_select             
                            loopFlag=false          ;;
            $'q' | $K_ESC ) menu_escape
                            loopFlag=false          ;;
            $K_UP         ) menu_move_up            ;;
            $K_DOWN       ) menu_move_down          ;;
            $K_LEFT       ) menu_switch_theme_shape ;;
            $K_RIGHT      ) menu_switch_theme_color ;;
            $'s'          ) menu_save_theme         ;;
            *             ) menu_iddle              ;;
        esac
    done
    menu_end
}

