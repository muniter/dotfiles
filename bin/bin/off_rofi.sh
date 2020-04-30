#!/bin/bash
I3EXIT='i3-msg exit'
DIALOG_RESULT=$(echo -e 'i3 lock\nexit i3\nsuspend\nreboot\nshutdown' | rofi -dmenu -i -p "Computer")

echo "This result is : $DIALOG_RESULT"
sleep 1;

if [ "$DIALOG_RESULT" = "i3 lock" ];
then
    exec i3lock
elif [ "$DIALOG_RESULT" = "exit i3" ];
then
    eval $I3EXIT
elif [ "$DIALOG_RESULT" = "suspend" ];
then
    exec systemctl suspend
elif [ "$DIALOG_RESULT" = "reboot" ];
then
    exec reboot
elif [ "$DIALOG_RESULT" = "shutdown" ];
then
    exec shutdown -h now
fi
