#!/bin/bash

function getStatusString() {
    declare -A WIDGETS
    WIDGETS['load']=`cut /proc/loadavg -f 1 -d ' '`
    WIDGETS['net']=`iwgetid --raw`
    WIDGETS['vol']="`amixer get Master | grep % -m 1 | cut -f 7 -d ' ' | grep -o '[0-9]*'`%"
    WIDGETS['bat']="`cat /sys/class/power_supply/BAT0/capacity`%"

    STATUS_STRING="";
    for K in ${!WIDGETS[@]}
    do
        STATUS_STRING+="$K: ${WIDGETS[$K]} | "
    done
    STATUS_STRING+=`date +'%H:%M %d.%m.%Y'`

    echo $STATUS_STRING
}

if [ -d /etc/X11/xinit/xinitrc.d ]; then
    for f in /etc/X11/xinit/xinitrc.d/*; do
        [ -x "$f" ] && . "$f"
    done
    unset f
fi

setxkbmap -layout us,ru -variant -option grp:alt_shift_toggle,grp_led:scroll,terminate:ctrl_alt_bksp
# xmodmap -pke gets you the keycodes
xmodmap -e "keycode 108 = Super_L" # reassign Alt_R to Super_L
xmodmap -e "remove mod1 = Super_L" # make sure X keeps it out of the mod1 group
export _JAVA_AWT_WM_NONREPARENTING=1 # fixes java empty windows
wmname LG3D # fixes java empty windows
xrdb -merge ~/.Xresources # reads .Xresources - mostly xterm settings

while xsetroot -name "$(getStatusString)"
do
    sleep 2
done &
exec dwm
