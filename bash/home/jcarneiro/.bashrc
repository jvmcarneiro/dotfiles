#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

source "$HOME/.shell_task"

# Aliases
## Launches pager defined above
alias less="${PAGER}"
alias zless="${PAGER}"
alias cat="vimcat"
## Adds colors to ls
alias ls="ls --color=auto"
## Sends a low-level hibernation call
alias hibernate="echo disk | sudo tee /sys/power/state"
## Creates a tag file in the current folder
alias ctagsvim="ctags -R . --extras=+q --fields=+i -n"
## Fix Screen issues with bigger screens
alias fixscreen="xrandr -s 1 && xrandr -s 0"
## Hybrid suspend
alias hybrid='sudo systemctl hybrid-sleep'
## Normal suspend
alias hybrid='sudo systemctl hybrid-sleep'
## Neomutt ease of use
alias mutt='neomutt'

# Set prompt
PS1='[\u@\h \W]\$ '
## Show number of inbox items in terminal prompt
export PS1='[$(task +in +PENDING count)]'$PS1

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:/usr/local/rvm/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"

# Quartus auto-configured this
export QSYS_ROOTDIR="/home/jcarneiro/intelFPGA_lite/16.1/quartus/sopc_builder/bin"
