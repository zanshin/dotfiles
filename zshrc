# Path to your oh-my-zsh configuration.
export ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
export ZSH_THEME="cello"

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
# zsh-syntax-highlighting must be last...
#plugins=(git textmate osx ruby rvm pow)
plugins=(zsh-syntax-highlighting)

# alias to rvm-prompt
#alias rvm-prompt=$HOME/.rvm/bin/rvm-prompt
source $ZSH/oh-my-zsh.sh

# Customize to your needs...
export PATH=/usr/local/bin:/usr/local/sbin:~/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/X11/bin

# Add RVM to PATH for scripting
#export PATH=$PATH:$HOME/.rvm/bin 

# -------------------------------------------------------------------
# Load RVM into a shell session *as a function*
# -------------------------------------------------------------------
[[ -s "$HOME/.rvm/scripts/rvm" ]] && source "$HOME/.rvm/scripts/rvm" 

# -------------------------------------------------------------------
# JVM settings
# -------------------------------------------------------------------
export SBT_OPTS=-XX:MaxPermSize=1024m

# -------------------------------------------------------------------
# Setup virtualenvwrapper
# -------------------------------------------------------------------
export WORKON_HOME=$HOME/.virtualenvs
export PROJECT_HOME=$HOME/Projects/python
#export VIRTUALENVWRAPPER_VIRTUALENV_ARGS='--no-site-packages'
export VIRTUAL_ENV_DISABLE_PROMPT='Y'
source /usr/local/bin/virtualenvwrapper.sh

# -------------------------------------------------------------------
# Load tmuxinator and export EDITOR as tmuxinator expects it
# -------------------------------------------------------------------
[[ -s $HOME/.tmuxinator/scripts/tmuxinator ]] && source $HOME/.tmuxinator/scripts/tmuxinator
export EDITOR=vim

# -------------------------------------------------------------------
# vi style incremental search
# -------------------------------------------------------------------
bindkey '^R' history-incremental-search-backward
bindkey '^S' history-incremental-search-forward
bindkey '^P' history-search-backward
bindkey '^N' history-search-forward 

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

# -------------------------------------------------------------------
# source z funtionality for directory hopping
# https://github.com/rupa/z
# -------------------------------------------------------------------
source ${HOME}/.dotfiles/z/z.sh

# -------------------------------------------------------------------
# Darwin specific settings
# -------------------------------------------------------------------
case `uname` in
  Darwin)
    # Undo Lion's aggressive setting of ~/Library to invisible
    /usr/bin/chflags nohidden ~/Library
    
    # usr precmd to set OS X Terminal window title 
    # http://timbabwe.com/2012/05/iterm_tab_and_window_titles_with_zsh/
    #precmd () { print -Pn "\e]2;%n@%M %~\a" }
    precmd () {
      tab_label=${PWD/${HOME}/\~} # use 'relative' path
      echo -ne "\e]2;${tab_label}\a" # set window title to full string
      echo -ne "\e]1;${tab_label: -24}\a" # set tab title to rightmost 24 characters
    }
    ;;
esac

# here since I use iTerm2 and zsh per https://rvm.io/integration/zsh/
__rvm_project_rvmrc

# finis
# mhn 2013.1.19
