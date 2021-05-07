#!/bin/sh

# ~/.xinitrc
#
# User xinitrc file, used by all X sessions started by xinit (startx) from that user

xrdb -merge ~/.Xresources
xmodmap ~/.Xmodmap
autorandr --change

exec pasystray&
exec nm-applet&
exec xidlehook-default&

exec awesome
