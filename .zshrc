# Oh-my-zsh installation path
export ZSH="$HOME/.oh-my-zsh"

# Theme
ZSH_THEME="robbyrussell"

# Adds colors to ls
alias ls='ls --color=auto'
# Creates a tag file in the current folder
alias ctagsvim='ctags -R . --extras=+q --fields=+i -n'
# Fix Screen issues with bigger screens
alias fixscreen='xrandr -s 1 && xrandr -s 0'
# Neomutt ease of use
alias mutt='neomutt'
# Terminal emacs
alias emacst='emacsclient -t'
# Visual client emacs
alias emacsc='emacsclient -c'
# Use vim as less
alias less='/usr/share/nvim/runtime/macros/less.sh'
# Always suspend then hibernate
alias suspend='sudo systemctl suspend-then-hibernate'

# Dots while waiting for completion 
COMPLETION_WAITING_DOTS="true"

# Improve history
setopt share_history
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000

# Insensitive hyphen completion
HYPHEN_INSENSITIVE="true"

# Plugins to load
plugins=(
    compleat
    last-working-dir
    vi-mode
)

# Bind keys for dircycle
bindkey "\e[1;6D" insert-cycledleft
bindkey "\e[1;6C" insert-cycledright

# Source oh-my-zsh
source $ZSH/oh-my-zsh.sh

# Change dir to last working dir on launch
lwd

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



#THIS MUST BE AT THE END OF THE FILE FOR SDKMAN TO WORK!!!
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"
fpath+=${ZDOTDIR:-~}/.zsh_functions

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
