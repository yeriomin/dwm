#!/bin/bash
while xsetroot -name "`date +'%H:%M %d.%m.%Y'`"
do
    sleep 1
done &
exec dwm
