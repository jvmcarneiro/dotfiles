#
# ~/.zprofile
#

# Source
[[ -e ~/.profile ]] && emulate sh -c 'source ~/.profile'

# Default permissions
umask 022

eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"
