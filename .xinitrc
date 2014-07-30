#!/bin/bash
export _JAVA_AWT_WM_NONREPARENTING=1
wmname LG3D
xrdb -merge ~/.Xresources
while xsetroot -name "`date +'%H:%M %d.%m.%Y'`"
do
sleep 5
done &
exec dwm
