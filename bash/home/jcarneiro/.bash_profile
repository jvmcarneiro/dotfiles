#
# ~/.bash_profile
#

# if .bashrc exists, source it
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Global variables
# Internet browser
export BROWSER="firefox-nightly"
# Text editor
export EDITOR="vim"
# Man-specific pager
export MANPAGER="/usr/bin/vimpager"
# Sets qt theme
export QT_QPA_PLATFORMTHEME="gtk2"
# Go-to for most text-displaying utilities
export PAGER="/home/jcarneiro/.vim/plugged/vimpager/vimpager"
# Editor that many scripts execute
export VISUAL="vim"
# Default x keyboard layout
export XKB_DEFAULT_LAYOUT="us"
# Default x keyboard variant
export XKB_DEFAULT_VARIANT="altgr-intl"
# Warns Java to not reparent wm
export _JAVA_AWT_WM_NONREPARENTING=1

# Path configurations
export PATH="${PATH}:$HOME/bin/"
export PATH="${PATH}:/usr/lib/python3.6/site-packages/"
export PATH="${PATH}:$HOME/.vim/plugged/vimpager/"
export PATH="${PATH}:$HOME/intelFPGA_lite/16.1/quartus/bin/"

# Increase history
export HISTSIZE=10000
export HISTFILESIZE=10000

# Quartus added this
export QSYS_ROOTDIR="/home/jcarneiro/intelFPGA_lite/16.1/quartus/sopc_builder/bin"

