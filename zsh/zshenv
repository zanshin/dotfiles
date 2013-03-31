# Mac OS X uses path_helper and /etc/paths.d to preload PATH, clear it out first
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    eval `/usr/libexec/path_helper -s`
fi

# Put Homebrew at the head of the path
# /usr/local/bin is also first in /etc/paths
export PATH="/usr/local/bin:$PATH"

# if rbenv is present, configure it for use
if which rbenv &> /dev/null; then
    # Put the rbenv entry at the front of the line
    export PATH="$HOME/.rbenv/bin:$PATH"

    # enable shims and auto-completion
    eval "$(rbenv init -)"
fi

# Add RVM to PATH for scripting, if rvm is present
if which rvm-prompt &> /dev/null; then
    export PATH=$HOME/.rvm/bin:$PATH
fi
