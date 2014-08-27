#!/bin/bash

SET_ROOT_WINDOW_NAME ()
{
WIRELESS_NETWORK_NAME=`iwgetid --raw`
BATTERY_NAME="BAT1"
BATTERY_CAPACITY="`cat /sys/class/power_supply/$BATTERY_NAME/capacity`%"
DATE=`date +'%H:%M %d.%m.%Y'`
xsetroot -name "$WIRELESS_NETWORK_NAME | $BATTERY_CAPACITY | $DATE";
}

export _JAVA_AWT_WM_NONREPARENTING=1
wmname LG3D
xrdb -merge ~/.Xresources
while SET_ROOT_WINDOW_NAME
do
sleep 5
done &
exec dwm
