#!/bin/bash

# options to be displayed
option0=" lock"
option1=" logout"
option2="鈴 suspend"
option3=" scheduled suspend (10min)"
option4=" scheduled suspend (20min)"
option5=" scheduled suspend (30min)"
option6="敏 reboot"
option7=" shutdown"

# options passed into variable
options="$option0\n$option2\n$option1\n$option6\n$option7"

chosen=$(echo -e "$options" | rofi -lines 5 -dmenu -p '')
echo "$chosen"
echo "$option0"
case "$chosen" in
    "$option0")
        lock;;
    "$option1")
        loginctl terminate-session ${XDG_SESSION_ID-};;
    "$option2")
        lock && systemctl suspend;;
	"$option3")
		sleep 600 && lock && systemctl suspend;;
	"$option4")
		sleep 1200 && lock && systemctl suspend;;
	"$option5")
		sleep 1800 && lock && systemctl suspend;;
    "$option6")
        systemctl reboot;;
	"$option7")
        systemctl poweroff;;
    *) exit 1 ;;
esac
