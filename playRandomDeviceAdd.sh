#!/bin/sh
#check folder
ogg123 /home/pi/DeviceAdd -qz &
pid=$!
sleep 2
kill -2 $pid
kill -2 $pid
exit 0