#
# ~/.bash_profile
#

export EDITOR="vim"
export BROWSER="firefox-nightly"
export XKB_DEFAULT_LAYOUT="us"
export XKB_DEFAULT_VARIANT="altgr-intl"


export PATH="$HOME/bin:${PATH}"

# Ruby configuration
GEM_HOME=$(ls -t -U | ruby -e 'puts Gem.user_dir')
GEM_PATH=$GEM_HOME
export PATH="${PATH}:$GEM_HOME/bin"
export PATH="~/.gem/ruby/2.4.0/bin:${PATH}"

## Display the current RVM ruby selection
PS1="\$(/usr/local/rvm/bin/rvm-prompt) $PS1"

# RVM bash completion
[[ -r /usr/local/rvm/scripts/completion ]] && . /usr/local/rvm/scripts/completion
[[ -s "/usr/local/rvm/scripts/rvm" ]] && source "/usr/local/rvm/scripts/rvm"

[[ -f ~/.bashrc ]] && . ~/.bashrc

