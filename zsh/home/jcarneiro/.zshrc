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
alias cat='vimcat'
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

# Zsh config
# Syntax highlighting
source /usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
# Load completion and prompt
autoload -Uz compinit promptinit
compinit
promptinit
# Menu-like completion
zstyle ':completion:*' menu select
setopt COMPLETE_ALIASES
# Auto rehash
zstyle ':completion:*' rehash true
# Subject prompt to expansion
setopt PROMPT_SUBST
# Good history search
autoload -Uz up-line-or-beginning-search down-line-or-beginning-search
zle -N up-line-or-beginning-search
zle -N down-line-or-beginning-search
[[ -n "$key[Up]"   ]] && bindkey -- "$key[Up]"   up-line-or-beginning-search
[[ -n "$key[Down]" ]] && bindkey -- "$key[Down]" down-line-or-beginning-search

# Oh-my-zsh installation path
ZSH=/usr/share/oh-my-zsh
# Zsh theme
ZSH_THEME="kolo"
# Insensitive hyphen completion
HYPHEN_INSENSITIVE="true"
# Enable autocorrection
ENABLE_CORRECTION="true"
# Red dots whilst waiting for completion.
COMPLETION_WAITING_DOTS="true"
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
