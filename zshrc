# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="zanshin"

# Set to this to use case-sensitive completion
# export CASE_SENSITIVE="true"

# Comment this out to disable weekly auto-update checks
# export DISABLE_AUTO_UPDATE="true"

# Uncomment following line if you want to disable colors in ls
# export DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
# export DISABLE_AUTO_TITLE="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Example format: plugins=(rails git textmate ruby lighthouse)
#plugins=(git textmate osx ruby rvm pow)

source $ZSH/oh-my-zsh.sh

# Customize to your needs...
# added my path 2011.7.19
export PATH=/usr/local/bin:/usr/local/apache-maven-2.2.1/bin:/usr/local/maven-1.1/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin:/usr/X11/bin:/Users/mark/.rbenv/bin

# rbenv stuff
eval "$(rbenv init -)"

# -------------------------------------------------------------------
# set up history
#   keep 100 commands internally (histsize)
#   store history in .zsh_history
#   write out 100 commands to stored history (savehist)
# -------------------------------------------------------------------
histsize=100
histfile=~/.zsh_history
savehist=100

# -------------------------------------------------------------------
# source my aliases and functions
# -------------------------------------------------------------------
source ${HOME}/.dotfiles/.zsh/aliases
source ${HOME}/.dotfiles/.zsh/functions


# finis
# mhn 2011.7.19
