# ----------------------------------------------------------------------------
# Using bits from Steve Losh
#	http://stevelosh.com/blog/2010/02/my-extravagant-zsh-prompt/
# 
# Modeled after Fino theme
# https://github.com/robbyrussell/oh-my-zsh/blob/master/themes/fino.zsh-theme
# ----------------------------------------------------------------------------

function prompt_char {
    git branch >/dev/null 2>/dev/null && echo '±' && return
    echo '○'
}

function virtualenv_info {
    [ $VIRTUAL_ENV ] && echo '('`basename $VIRTUAL_ENV`') '
}

function box_name {
    [ -f ~/.box-name ] && cat ~/.box-name || hostname -s
}

local rvm_ruby=''
if which rvm-prompt &> /dev/null; then
  rvm_ruby='$(rvm-prompt)'
else
  if which rbenv &> /dev/null; then
    rvm_ruby='$(rbenv version | sed -e "s/ (set.*$//")'
  fi
fi

local current_dir='${PWD/#$HOME/~}'
local git_info='$(git_prompt_info)'


PROMPT="
%{$fg[blue]%}%n%{$reset_color%} at %{$fg[yellow]%}$(box_name)%{$reset_color%} in %{$fg[green]%}${current_dir}%{$reset_color%}${git_info} 
$(prompt_char) "

RPROMPT='%{$fg[green]%}$(virtualenv_info)%{$reset_color%}% %{$fg[red]%}$(rvm_ruby)%{$reset_color%}'


# error prompt
export SPROMPT="Correct $fg[red]%R$reset_color to $fg[green]%r$reset_color [(y)es (n)o (a)bort (e)dit]? "

# untracked attributes relies on Steve Losh version of oh-my-zsh
ZSH_THEME_GIT_PROMPT_PREFIX=" on %{$fg[blue]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="%{$fg[yellow]%} [dirty]"
ZSH_THEME_GIT_PROMPT_UNTRACKED="%{$fg[yellow]%} [untracked]"
ZSH_THEME_GIT_PROMPT_CLEAN=""



