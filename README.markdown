This repository holds my configuration files so that I can clone them to other machines
easily.

My primary OS is OS X (10.9.x) and some of these configurations are tuned to work on that platform. The `bash` files are more generic and friendly toward other Unix-based operating systems. 

#Installation

    git clone git://github.com/zanshin/dotfiles.git ~/.dotfiles
	
# Updating
There are still a couple git submodules included in this configuration. On a new
installation these submodules need to be initialized and updated.

    $ cd ~/.dotfiles
    $ git submodule init 
    $ git submodule update 

It is also possible to use `git pull` to update the submodules.

    $ cd ~/.dotfiles
    $ git submodule foreach git pull origin master

Vundle managed Vim bundles maybe updated from the command line via

    $ vim +PluginInstall +qall

#Setup
## Homebrew
On those Mac OS machines where I install Homebrew I also edit `/etc/paths` to move the `/usr/local/bin` entry to the top of the list. This ensures that Homebrew-managed programs and libraries occur prior to `/usr/bin` and system-provided programs and libraries. The resulting `/etc/paths` files looks like this:

    /usr/local/bin
    /usr/bin
    /bin
    /usr/sbin
    /sbin

The `~/.dotfiles/brew/Brewfile` acts as a bundle for Homebrew. Use `brew bundle ~/.dotfiles/brew/Brewfile` to set up brews.
    
## zsh
For zsh configuration create the following symlinks:

    ln -s ~/.dotfiles/zsh ~/.zsh
    ln -s ~/.dotfiles/zsh/zshrc ~/.zshrc
    ln -s ~/.dotfiles/zsh/zshenv ~/.zshenv
    ln -s ~/.dotfiles/zsh/zprofile ~/.zprofile
		
## ssh
For ssh configuration, create the following symlink:

    ln -s ~/.dotfiles/ssh/config ~/.ssh/config

## Vim
For Vim configuration and use, create the following symlinks:

    ln -s ~/.dotfiles/vim ~/.vim
    ln -s ~/.dotfiles/vim/vimrc ~/.vimrc
    ln -s ~/.dotfiles/vim/vimrc.bundles ~/.vimrc.bundles
    ln -s ~/.dotfiles/vim/gvimrc ~/.gvimrc

To install Vim bundles, which are managed via Vundle, via the command line run

    vim +PluginInstall +qall

From inside of Vim run

    :PluginInstall

If this is the first time setting up Vim on the machine, it will be necessary to install Vundle itself, prior to teh bundles.

    git clone https://github.com/VundleVim/Vundle.vim.git ~/.vim/bundle/Vundle.vim

All Bundles and their associated configurations are kept in `vimrc.bundles`. This file is sourced inside `vimrc` only if found. This allows a minified version of my Vim configuration to be installed on remote servers, without having to install all the bundles I normally have. 

The `YouCompleteMe` bundle requires an additional compile step. Go read teh "Installation" section on http://valloric.github.io/YouCompleteMe/. Short version is:

    $ brew list # if cmake isn't there, brew install cmake
    $ cd ~/.vim/bundle/YouCompleteMe
    $ ./install.sh --clang-completer

## bash
For those machines where zsh isn't installed or won't easily work, create the
following symlinks:

    $ ln -s ~/.dotfiles/bash/bash_profile ~/.bash_profile
    $ ln -s ~/.dotfiles/bash/bashrc ~/.bashrc
    $ ln -s ~/.dotfiles/bash/bash_aliases ~/.bash_aliases
    $ ln -s ~/.dotfiles/bash/bash_history ~/.bash_history

## Git
For Git configuration and global ignore files, create these symlinks:

    $ ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
    $ ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global

For machines where Sublime Text 2 cannot be installed, link
`git/gitconfig_remote` instead. This will use `vimdiff` as the merge and diff
tool rather than ST2.

## Mercurial (hg)
For Mercurial configuration and global ignore files, create these symlinks:

    $ ln -s ~/.dotfiles/hg/hgrc ~/.hgrc
    $ ln -s ~/.dotfiles/hg/hgignore_global ~/.hgignore_global

## Gem
In order to prevent `gem install` or `gem update` from downloading RDoc and RI, symlink this file.

    $ ln -s ~/.dotfiles/gem/gemrc ~/.gemrc

## TextMate (mate)
For TextMate 2 settings create the following symlink:

    $ ln -s ~/.dotflles/textmate/tm_properties ~/.tm_properties

## tmux (terminal multiplexer) configuration
For tmux configuration create this symlink:

    $ ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf

Setup `tmuxinator` by installing it's gem

    $ gem install tmuxinator

And link in the directory containing the YML files for the `mux` command.

    $ ln -s ~/.dotfiles/tmux/tmuxinator ~/.tmuxinator

## Sublime Text 2 (subl)
Install Package Control following the instructions here: http://wbond.net/sublime_packages/package_control

For Sublime Text 2 settings, remove the `User` directory from
`~/Library/Application Support/Sublime Text 2/Packages`. Then add this symlink:

    $ cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages
    $ ln -s ~/.dotfiles/sublimetext/User User

Finally, to enable the command line tool, `subl`, add this symlink:

    $ ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

##z
To enable z directory function from https://github.com/rupa/z, source the
`z.sh` script in the `.zshrc` file: 

    source ${HOME}/.dotfiles/z/z.sh

## Doing
Install `doing` gem (https://github.com/ttscoff/doing/ & http://brettterpstra.com/2014/03/15/scatterbrains-3-a-new-tool-for-doing/)

    $ [sudo] gem install doing

Create symlink to `doingrc` file.

    $ ln -s ~/.dotfiles/doing/doingrc ~/.doingrc

## OpenConnect
An alternative to using Cisco's AnyConnect.

Requires that `openconnect` be installed via Homebrew and that TUN/TAP for OS X be installed. See http://zanshin.net/2013/08/27/setup-openconnect-for-mac-os-x-lion/
for details.

    $ ln -s ~/.dotfiles/openconnect/openconnect ~/.openconnect



