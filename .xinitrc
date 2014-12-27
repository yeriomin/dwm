#!/bin/bash

SET_ROOT_WINDOW_NAME ()
{
LOAD="load: `cut /proc/loadavg -f 1 -d ' '`"
WIRELESS_NETWORK_NAME="net: `iwgetid --raw`"
VOLUME="vol: $(amixer get Master | grep % -m 1 | cut -f 7 -d ' ' | grep -o '[0-9]*')%"
BATTERY_NAME="BAT0"
BATTERY_CAPACITY="$BATTERY_NAME: `cat /sys/class/power_supply/$BATTERY_NAME/capacity`%"
DATE=`date +'%H:%M %d.%m.%Y'`
xsetroot -name "$LOAD | $WIRELESS_NETWORK_NAME | $BATTERY_CAPACITY | $VOLUME | $DATE";
}

if [ -d /etc/X11/xinit/xinitrc.d ]; then
  for f in /etc/X11/xinit/xinitrc.d/*; do
    [ -x "$f" ] && . "$f"
  done
  unset f
fi

setxkbmap -layout us,ru -variant -option grp:alt_shift_toggle,grp_led:scroll,terminate:ctrl_alt_bksp
export _JAVA_AWT_WM_NONREPARENTING=1
wmname LG3D
xrdb -merge ~/.Xresources
while SET_ROOT_WINDOW_NAME
do
sleep 5
done &
exec dwm
