#!/bin/sh



# Begin of default config
userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps
if [ -f $sysresources ]; then
    xrdb -merge $sysresources
fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then
    xrdb -merge "$userresources"
fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs
if [ -d /etc/X11/xinit/xinitrc.d ] ; then
 for f in /etc/X11/xinit/xinitrc.d/?*.sh ; do
  [ -x "$f" ] && . "$f"
 done
 unset f
fi
# End of default config



# Shows battery status at start (same as in battery.sh acpi action)
charge=`acpi | awk '{gsub(/%,/, ""); print $4}'`
connect=`acpi | awk '{gsub(/,/, ""); print $3}'`
if (( "$charge" <= 99 && "$charge" > 90 )); then
	if [[ "$connect" == "Charging" ]]; then
		notify-send -u normal "Battery level: $charge%" "You can remove the charger now"
	else
		notify-send -u normal "Battery level: $charge%"
	fi
elif (( "$charge" <= 90 && "$charge" > 33 )); then
	notify-send -u normal "Battery level: $charge%"
elif (( "$charge" <= 33 && "$charge" > 18 )); then
	if [[ "$connect" == "Discharging" ]]; then
		notify-send -u normal "Battery level: $charge%!" "Time to connect the charger!"
	else
		notify-send -u normal "Battery level: $charge%!"
	fi
elif (( "$charge" <= 18 && "$charge" >= 0 )); then
	if [["$connect" == "Discharging" ]]; then
		notify-send -u critical "Battery level: $charge%!" "You better save that work..."
	else
		notify-send -u critical "Battery level: $charge%!"
	fi
fi

# Main monitor by default
mons -o

dropbox &
dunst &

exec i3
