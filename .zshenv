#
# ~/.zshenv
#

# Default terminal
export TERMINAL="alacritty"
# Internet browser
export BROWSER="firefox"
# Terminal editor
export EDITOR="nvim"
# Gui editor
export VISUAL="nvim"
# Alternate editor
export ALTERNATE_EDITOR=""
# Sudo text editor
export SUDO_EDITOR="nvim"
# Man-specific pager
export MANPAGER="less"
# Go-to for most text-displaying utilities
export PAGER="less"
# Default x keyboard layout
export XKB_DEFAULT_LAYOUT="us"
# Warn Java to not reparent wm
export _JAVA_AWT_WM_NONREPARENTING=1
# Fixes location bug
export LC_ALL="en_US.UTF-8"
# Fixes titlebars in gtk
export GTK_CSD=0
# Local user install npm global packages
export npm_config_prefix="$HOME/.node_modules"
# Support for go language
export GOPATH="$HOME/gopath"
# Python modules path
export PYTHONPATH="$HOME/.local/lib/python3.7/site-packages:${PYTHONPATH}"

# Allow oh-my-zsh themes to work correctly (according to arch wiki)
setopt NO_GLOBAL_RCS

# Path configurations
export PATH="$HOME/.node_modules/bin:${PATH}"
export PATH="$HOME/bin:/usr/local/bin:${PATH}"
export PATH="$HOME/.local/bin:${PATH}"
export PATH="$HOME/intelFPGA_lite/16.1/quartus/bin:${PATH}"
export PATH="$HOME/.node_modules/lib/node_modules:${PATH}"
export PATH="$HOME/.config/rofi/bin:${PATH}"
export PATH="$GOPATH:$GOPATH/bin:${PATH}"
export PATH="/usr/lib/ccache/bin:${PATH}"
export PATH="/usr/lib/python3.6/site-packages:${PATH}"
export PATH="/usr/local/go/bin:${PATH}"

# Increase history
export HISTSIZE=10000
export HISTFILESIZE=10000

# Tty colors
if [ "$TERM" = "linux" ]; then
    echo -en "\e]P03B4252" #black
    echo -en "\e]P8434C5E" #darkgrey
    echo -en "\e]P1BF616A" #darkred
    echo -en "\e]P9D08770" #red
    echo -en "\e]P2A3BE8C" #darkgreen
    echo -en "\e]PAA3BE8C" #green
    echo -en "\e]P3EBCB8B" #brown
    echo -en "\e]PBEBCB8B" #yellow
    echo -en "\e]P45E81AC" #darkblue
    echo -en "\e]PC81A1C1" #blue
    echo -en "\e]P5B48EAD" #darkmagenta
    echo -en "\e]PDB48EAD" #magenta
    echo -en "\e]P688C0D0" #darkcyan
    echo -en "\e]PE8FBCBB" #cyan
    echo -en "\e]P7D8DEE9" #lightgrey
    echo -en "\e]PFE5E9F0" #white
    clear #for background artifacting
fi
