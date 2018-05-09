#
# ~/.zshenv
#

# Internet browser
export BROWSER="firefox"
# Terminal editor
export EDITOR="emacsclient -t"
# Gui editor
export VISUAL="emacsclient -c -a emacs"
# Alternate editor
export ALTERNATE_EDITOR=""
# Sudo text editor
export SUDO_EDITOR="emacs -nw"
# Man-specific pager
export MANPAGER="less"
# Sets qt theme
export QT_QPA_PLATFORMTHEME="gtk2"
# Go-to for most text-displaying utilities
export PAGER="less"
# Default x keyboard layout
export XKB_DEFAULT_LAYOUT="us"
# Default x keyboard variant
export XKB_DEFAULT_VARIANT="altgr-intl"
# Warn Java to not reparent wm
export _JAVA_AWT_WM_NONREPARENTING=1
# Fixes location bug
export LC_ALL="en_US.UTF-8"
# Fixes titlebars in gtk
export GTK_CSD=0
# Fixes other theming issues with gtk
export LD_PRELOAD="/usr/lib/libgtk3-nocsd.so.0"
# Local user install npm global packages
export npm_config_prefix="~/.node_modules"

# Path configurations
export PATH="$HOME/.node_modules/bin:$PATH"
export PATH="$HOME/bin:/usr/local/bin:${PATH}"
export PATH="${PATH}:/usr/lib/python3.6/site-packages/"
export PATH="${PATH}:$HOME/intelFPGA_lite/16.1/quartus/bin/"

# Increase history
export HISTSIZE=10000
export HISTFILESIZE=10000

# Quartus added this
export QSYS_ROOTDIR="/home/jcarneiro/intelFPGA_lite/16.1/quartus/sopc_builder/bin"
