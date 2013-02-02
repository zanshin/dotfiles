# Mac OS X uses path_helper and /etc/paths.d to preload PATH, clear it out first
if [ -x /usr/libexec/path_helper ]; then
    PATH=''
    eval `/usr/libexec/path_helper -s`
fi

# Put the rbenv entry at the front of the line
export PATH="$HOME/.rbenv/bin:$PATH"

# enable shims and auto-completion
eval "$(rbenv init -)"

