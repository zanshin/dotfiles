# ----------------------------------------------------------------------------
# Using bits from Steve Losh
#	http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
# ----------------------------------------------------------------------------

# ----------------------------------------------------------------------------
# Shows little symbol '±' if you're currently at a git repo,
#                     '☿' if you're currently at a hg repo,
#                 and '○' all other times
# ----------------------------------------------------------------------------
function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    hg root >/dev/null 2>/dev/null && echo '☿' && return
    echo '○'
}

# ----------------------------------------------------------------------------
# hg prompt
# depends upon ~/Projects/hg/hg-prompt
# ----------------------------------------------------------------------------
function hg_prompt_info {
    hg prompt --angle-brackets "\
< on %{$fg[magenta]%}<branch>%{$reset_color%}>\
< at %{$fg[yellow]%}<tags|%{$reset_color%}, %{$fg[yellow]%}>%{$reset_color%}>\
%{$fg[green]%}<status|modified|unknown><update>%{$reset_color%}<
patches: <patches|join( → )|pre_applied(%{$fg[yellow]%})|post_applied(%{$reset_color%})|pre_unapplied(%{$fg_bold[black]%})|post_unapplied(%{$reset_color%})>>" 2>/dev/null
}

# ----------------------------------------------------------------------------
# git prompt variables
# depends on using Steve Losh fork of oh-my-zsh
# ----------------------------------------------------------------------------
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} is dirty"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%} has untracked changes"
ZSH_THEME_GIT_PROMPT_CLEAN=""

# ----------------------------------------------------------------------------
# zee prompt (ha ha)
# ----------------------------------------------------------------------------
PROMPT='
%{$fg[blue]%}%n%{$reset_color%} at %{$fg[yellow]%}%m%{$reset_color%} in %{$fg[green]%}${PWD/#$HOME/~}%b%{$reset_color%}$(hg_prompt_info)$(git_prompt_info)
$(prompt_char) '

# ----------------------------------------------------------------------------
# rubies are red, and so my Ruby version is too
#----------------------------------------------------------------------------
RPROMPT='%{$fg[red]%}$(rbenv version-name)%{$reset_color%}%'

# git prompt information
#setopt prompt_subst
#autoload colors zsh/terminfo
#colors

#function __git_prompt {
#  local DIRTY="%{$fg[yellow]%}"
#  local CLEAN="%{$fg[green]%}"
#  local UNMERGED="%{$fg[red]%}"
#  local RESET="%{$terminfo[sgr0]%}"
#  git rev-parse --git-dir >& /dev/null
#  if [[ $? == 0 ]]
#  then
#    echo -n "["
#    if [[ `git ls-files -u >& /dev/null` == '' ]]
#    then
#      git diff --quiet >& /dev/null
#      if [[ $? == 1 ]]
#      then
#        echo -n $DIRTY
#      else
#        git diff --cached --quiet >& /dev/null
#        if [[ $? == 1 ]]
#        then
#          echo -n $DIRTY
#        else
#          echo -n $CLEAN
#        fi
#      fi
#    else
#      echo -n $UNMERGED
#    fi
#    echo -n `git branch | grep '* ' | sed 's/..//'`
#    echo -n $RESET
#    echo -n "]"
#  fi
#}

# display Ruby information, only when RVM is installed and only when you are using a RVM installed ruby.
#function rvm_ruby_prompt {
#    ruby_version=$(~/.rvm/bin/rvm-prompt)
#    if [ -n "$ruby_version" ]; then
#		echo "[$ruby_version]"
#	fi
#}

###############################################################
# commenting out all below mhn 2011-08-29
#ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[white]%}"
#ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%})"
#
# Text to display if the branch is dirty
#ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[red]%} *%{$reset_color%}" 
#
# Text to display if the branch is clean
#ZSH_THEME_GIT_PROMPT_CLEAN="" 
#
# Colors vary depending on time lapsed.
#ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT="%{$fg[green]%}"
#ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM="%{$fg[yellow]%}"
#ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG="%{$fg[red]%}"
#ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL="%{$fg[cyan]%}"
#

#
# Git sometimes goes into a detached head state. git_prompt_info doesn't
# return anything in this case. So wrap it in another function and check
# for an empty string.
#function check_git_prompt_info() {
#    if git rev-parse --git-dir > /dev/null 2>&1; then
#        if [[ -z $(git_prompt_info) ]]; then
#            echo "%{$fg[magenta]%}detached-head%{$reset_color%})"
#        else
#            echo "$(git_prompt_info)"
#        fi
#    fi
#}
#
# Determine if we are using a gemset.
#function rvm_gemset() {
#    GEMSET=`rvm gemset list | grep '=>' | cut -b4-`
#    if [[ -n $GEMSET ]]; then
#        echo "%{$fg[yellow]%}$GEMSET%{$reset_color%}|"
#    fi 
#}
#
# Determine the time since last commit. If branch is clean,
# use a neutral color, otherwise colors will vary according to time.
#function git_time_since_commit() {
#    if git rev-parse --git-dir > /dev/null 2>&1; then
#        # Only proceed if there is actually a commit.
#        if [[ $(git log 2>&1 > /dev/null | grep -c "^fatal: bad default revision") == 0 ]]; then
#            # Get the last commit.
#            last_commit=`git log --pretty=format:'%at' -1 2> /dev/null`
#            now=`date +%s`
#            seconds_since_last_commit=$((now-last_commit))
#
#            # Totals
#            MINUTES=$((seconds_since_last_commit / 60))
#            HOURS=$((seconds_since_last_commit/3600))
#           
#            # Sub-hours and sub-minutes
#            DAYS=$((seconds_since_last_commit / 86400))
#            SUB_HOURS=$((HOURS % 24))
#            SUB_MINUTES=$((MINUTES % 60))
#            
#            if [[ -n $(git status -s 2> /dev/null) ]]; then
#                if [ "$MINUTES" -gt 30 ]; then
#                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_LONG"
#                elif [ "$MINUTES" -gt 10 ]; then
#                    COLOR="$ZSH_THEME_GIT_TIME_SHORT_COMMIT_MEDIUM"
#                else
#                    COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_SHORT"
#                fi
#            else
#                COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
#            fi
#
#            if [ "$HOURS" -gt 24 ]; then
#                echo "($(rvm_gemset)$COLOR${DAYS}d${SUB_HOURS}h${SUB_MINUTES}m%{$reset_color%}|"
#            elif [ "$MINUTES" -gt 60 ]; then
#                echo "($(rvm_gemset)$COLOR${HOURS}h${SUB_MINUTES}m%{$reset_color%}|"
#            else
#                echo "($(rvm_gemset)$COLOR${MINUTES}m%{$reset_color%}|"
#            fi
#        else
#            COLOR="$ZSH_THEME_GIT_TIME_SINCE_COMMIT_NEUTRAL"
#            echo "($(rvm_gemset)$COLOR~|"
#        fi
#    fi
#}
