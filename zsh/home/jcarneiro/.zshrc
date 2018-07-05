#
# ~/.zshrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# If .shell_task script is present, source it
# shellcheck source=.shell_task
[[ -f ~/.shell_task ]] && . ~/.shell_task

# Aliases
## Launches pager defined above
alias less='${PAGER}'
alias zless='${PAGER}'
## Adds colors to ls
alias ls='ls --color=auto'
## Creates a tag file in the current folder
alias ctagsvim='ctags -R . --extras=+q --fields=+i -n'
## Fix Screen issues with bigger screens
alias fixscreen='xrandr -s 1 && xrandr -s 0'
## Hibernation call
alias hibernate='sudo systemctl hibernate'
## Hybrid suspend
alias hybrid='sudo systemctl hybrid-sleep'
## Normal suspend
alias suspend='sudo systemctl suspend'
## Neomutt ease of use
alias mutt='neomutt'
## Terminal emacs
alias emacst='emacsclient -t'
## Visual client emacs
alias emacsc='emacsclient -c'

# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
setopt extendedglob nomatch notify
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/jcarneiro/.zshrc'
# End of lines added by compinstall

# Zsh config
# Load completion and prompt
autoload -Uz compinit promptinit
compinit
promptinit
setopt COMPLETE_ALIASES
# Auto rehash
zstyle ':completion:*' rehash true
# Subject prompt to expansion
setopt PROMPT_SUBST

# Oh-my-zsh installation path
ZSH=/usr/share/oh-my-zsh
# Oh-my-zsh custom folder
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom/"
# Zsh theme
ZSH_THEME="flazz"
# Insensitive hyphen completion
HYPHEN_INSENSITIVE="true"
# Plugins to load
plugins=(
    compleat
    dircycle
    dirhistory
    dirpersist
    git
    git-extras
    git-flow
    last-working-dir
    node
    npm
    pass
    pip
    python
    sudo
    taskwarrior
    vi-mode
)

# Cache setup
ZSH_CACHE_DIR=$HOME/.cache/oh-my-zsh
if [[ ! -d $ZSH_CACHE_DIR ]]; then
  mkdir $ZSH_CACHE_DIR
fi

# Source ohmyzsh
source $ZSH/oh-my-zsh.sh

# Up and down arrow fix for vi-mode
if [[ "${terminfo[kcuu1]}" != "" ]]; then
  autoload -U up-line-or-beginning-search
  zle -N up-line-or-beginning-search
  bindkey "${terminfo[kcuu1]}" up-line-or-beginning-search
fi
if [[ "${terminfo[kcud1]}" != "" ]]; then
  autoload -U down-line-or-beginning-search
  zle -N down-line-or-beginning-search
  bindkey "${terminfo[kcud1]}" down-line-or-beginning-search
fi
