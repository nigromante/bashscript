#!/bin/bash


declare -a mplayer_list

mplayer_devices() {
  for disp in $(v4l2-ctl --list-devices | grep "/dev/video" ) ; do
    mplayer_list+=( $disp ) 
  done
}

mplayer_devices_list() {
  mplayer_devices
  _opciones="${mplayer_list[@]}"
  printf -v "${1}" "$_opciones"
}


mplayer_play_webcam() {
    mplayer tv:// -tv driver=v4l2:width=720:height=480:device=$1:fps=30:outfmt=yuy2  -msglevel all=-1  
}


mplayer_play_easycap() {
    mplayer tv:// -tv driver=v4l2:width=720:height=480:outfmt=uyvy:norm=NTSC-M:device=$1:input=0:fps=25 -vo sdl -nosound
}


capture_video() {

	  _date=$(date +"%Y-%m-%d_%H:%M:%S")
    _device="/dev/video2"
    _time="10:00"
    _file="~/Vídeos/Camera/$_date.mkv"

    peval ffmpeg -an -v 0 -f v4l2 -framerate 30 -video_size 720x576  -i $_device  -segment_time $_time   $_file  &
}

