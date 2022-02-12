# Configuration Details

This readme file details each of the tools for which I keep configuration files under version
control. For information on installing the configuration files, please see the [README](README.markdown).

## Homebrew
On those macOS machines where I install Homebrew I also edit `/etc/paths` to move the `/usr/local/bin` entry to the top of the list. This ensures that Homebrew-managed programs and libraries occur prior to `/usr/bin` and system-provided programs and libraries. The resulting `/etc/paths` files looks like this:

    /usr/local/bin
    /usr/bin
    /bin
    /usr/sbin
    /sbin

The `~/.dotfiles/brew/Brewfile` acts as a bundle for Homebrew. Use `brew bundle ~/.dotfiles/brew/Brewfile` to set up brews.

## bash
In September 2020 I reorganized my bash configuration files. The `.bash-profile` now just sources
`.bashrc`. This means that I get the same configuration whether I'm in an interactive,
non-interactive, login, or non-login shell.

`.bashrc` sources everything else. The files containing aliases, functions, exports, key bindings,
colors, and the path configuration, are now all stored in `~/.config/bash.d`. This simplifies the
file listing of `$HOME`, as the are only three bash files there now, `.bash_profile`, `.bashrc`, and
`.bash_history`.

The `install.sh` script has been refactored to properly setup the new file scheme. Old
symlinks/files will need to be removed manually.

To manually install this bash configuration, create the following symlinks.

    $ ln -s ~/.dotfiles/bash/bash_profile ~/.bash_profile
    $ ln -s ~/.dotfiles/bash/bashrc ~/.bashrc
    $ ln -s ~/.dotfiles/bash/bash.d ~/.config/bash.d


## ssh
For ssh configuration, create the following symlink:

    ln -s ~/.dotfiles/ssh/config ~/.ssh/config

## Neovim (nvim)
For Neovim configuration, create the following symlink:

    ln -sn ~/.dotfiles/nvim ~/.config/nvim

The `n` flag on the `ln` command treats directories as files when making the link. This prevents the
link command from nesting the destination under an already existing directory.

As of February 2022, my Neovim configuration has been converted to the new Lua language format. The
vimscript-based configuration has been deprecated. The new configuration uses Packer to manage
plugins. Packer should install automatically the first time Neovim is used after this configuration
is put into place.

## Git
For Git configuration and global ignore files, create these symlinks:

    $ ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
    $ ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global

## Gem
In order to prevent `gem install` or `gem update` from downloading RDoc and RI, symlink this file.

    $ ln -s ~/.dotfiles/gem/gemrc ~/.gemrc

## tmux (terminal multiplexer) configuration
For tmux configuration create this symlink:

    $ ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

My tmux configuration doesn't always work on Linux - depending the Linux distribution being used. The
`tmux.linux` file is an alternate tmux configuration that can be linked on Linux.


## config
The $XDG_CONFIG_HOME location (as far as I know) is `$HOME/.config`. On Linux, and increasingly on
macOS, tools are placing their configurations under `~/.config`. At present have font, polybar, and
i3 configurations for Arch and Antergos stored in this directory. The Neovim configuration lives in
$XDG_CONFIG_HOME/nvim, but I keep it separately in this repository.

## mutt
I have threatened to use mutt for email more than once. These two directories contain the
configurations that resulted from these experiments. Do not blindly copy these and use them.
Really.

## scripts
These are some tmux setup scripts that I use. Highly personalized.


## No longer in use

### Vim
My use of Vim has virtually stopped. I've switched to using Neovim exclusively on all my devices. My
Vim configuration is out of date and no longer actively maintained.

For Vim configuration and use, create the following symlinks:

    ln -s ~/.dotfiles/vim ~/.vim
    ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
    ln -s ~/.dotfiles/vim/vimrc.bundles ~/.vimrc.bundles
    ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc

On remote servers where the Vim version maybe older or not under my control, eliminate the
`.vimrc.bundles` symlink. All bundles and their settings are encapsulated in this file. The `.vimrc`
file will default the color scheme and spelling dictionary settings if `.vimrc.bundles` is not
found.

To install vim-plug managed plugins run the following command from within Vim:

    :PlugInstall

To install vim-plug run the following command:

    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

### Mercurial (hg)
For Mercurial configuration and global ignore files, create these symlinks:
    $ ln -s ~/.dotfiles/hg/hgrc ~/.hgrc
    $ ln -s ~/.dotfiles/hg/hgignore_global ~/.hgignore_global

### OpenConnect
An alternative to using Cisco's AnyConnect.

### Sublime Text 2 (subl)
Install Package Control following the instructions here: http://wbond.net/sublime_packages/package_control

For Sublime Text 2 settings, remove the `User` directory from
`~/Library/Application Support/Sublime Text 2/Packages`. Then add this symlink:

    $ cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages
    $ ln -s ~/.dotfiles/sublimetext/User User

Finally, to enable the command line tool, `subl`, add this symlink:

    $ ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

Requires that `openconnect` be installed via Homebrew and that TUN/TAP for OS X be installed. See http://zanshin.net/2013/08/27/setup-openconnect-for-mac-os-x-lion/
for details.

$ ln -s ~/.dotfiles/openconnect/openconnect ~/.openconnect

### ohmyzsh
This is how I got introduced to zsh. I haven't used or updated this configuration in a very long
time. Do a search for `onmyzsh` and follow the directions you find there rather than using my
ancient, crufy, setup.

### TextMate (mate)
For TextMate 2 settings create the following symlink:

    $ ln -s ~/.dotflles/textmate/tm_properties ~/.tm_properties

### zsh - No longer maintained
    For zsh configuration create the following symlinks:

    ln -s ~/.dotfiles/zsh ~/.zsh
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
    ln -s ~/.dotfiles/zsh/zshenv ~/.zshenv
    ln -s ~/.dotfiles/zsh/zprofile ~/.zprofile

