#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Colors ls
alias ls='ls --color=auto'

# Hybrid suspend by default
alias suspend='sudo systemctl hybrid-sleep'

# Other aliases
alias mutt='neomutt'

# Taskwarrior stuff

## Add to inbox
alias in='task add +in'

## Add to tickle folder
tickle () {
	deadline=$1
	shift
	in +tickle wait:$deadline $@
}
alias tick=tickle

# Set prompt
PS1='[\u@\h \W]\$ '

## Show number of inbox items in terminal prompt
export PS1='[$(task +in +PENDING count)]'$PS1

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:/usr/local/rvm/bin"

# Add RVM to PATH for scripting. Make sure this is the last PATH variable change.
export PATH="$PATH:$HOME/.rvm/bin"
