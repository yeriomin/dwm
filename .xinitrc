#!/bin/bash

SET_ROOT_WINDOW_NAME ()
{
LOAD="load: `cut /proc/loadavg -f 1 -d ' '`"
WIRELESS_NETWORK_NAME="net: `iwgetid --raw`"
BATTERY_NAME="BAT1"
BATTERY_CAPACITY="$BATTERY_NAME: `cat /sys/class/power_supply/$BATTERY_NAME/capacity`%"
DATE=`date +'%H:%M %d.%m.%Y'`
xsetroot -name "$LOAD | $WIRELESS_NETWORK_NAME | $BATTERY_CAPACITY | $DATE";
}

setxkbmap -layout us,ru -variant -option grp:alt_shift_toggle,grp_led:scroll,terminate:ctrl_alt_bksp
export _JAVA_AWT_WM_NONREPARENTING=1
wmname LG3D
xrdb -merge ~/.Xresources
while SET_ROOT_WINDOW_NAME
do
sleep 5
done &
exec dwm
