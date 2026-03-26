
#!/bin/bash


menutheme_color_names=(
    "america"
    "loki"
    "barton"
    "widow"
    "hulk"
    "ironman"
    "vision"
  )
menutheme_color_n="${#menutheme_color_names[@]}"


menutheme_color_set() {
  eval "menutheme_color_$1"
}

menutheme_color_loki() {
  BORDER=$DARKGREEN
  ICON_SELECTED=$PURPLE
  TEXT_SELECTED=$YELLOW
  TEXT_NORMAL=$LIGHTGREEN
  TEXT_TITLE=$LIGTHPURPLE 
}

menutheme_color_barton() {
  BORDER=$PURPLE
  ICON_SELECTED=$BORDER
  TEXT_SELECTED=$YELLOW
  TEXT_NORMAL=$BLUE
}

menutheme_color_america() {
  BORDER=$LIGHTBLUE
  ICON_SELECTED=$WHITE
  TEXT_SELECTED=$LIGHTRED
  TEXT_NORMAL=$BORDER
}

menutheme_color_widow() {
  BORDER=$LIGHTGRAY
  ICON_SELECTED=$DARKGRAY
  TEXT_SELECTED=$WHITE
  TEXT_NORMAL=$BORDER
}

menutheme_color_hulk() {
  BORDER=$GREEN
  ICON_SELECTED=$WHITE
  TEXT_SELECTED=$LIGHTGREEN
  TEXT_NORMAL=$BORDER
}

menutheme_color_ironman() {
  BORDER=$LIGHTRED
  ICON_SELECTED=$TEXT_SELECTED
  TEXT_SELECTED=$YELLOW
  TEXT_NORMAL=$BORDER
}

menutheme_color_vision() {
  BORDER=$YELLOW
  ICON_SELECTED=$PURPLE
  TEXT_SELECTED=$WHITE
  TEXT_NORMAL=$BORDER
}

