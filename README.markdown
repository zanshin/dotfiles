This repository holds my configuration files so that I can clone them to other machines
easily.

##Installation:

    git clone git://github.com/zan5hin/dotfiles.git ~/.dotfiles
	
## Updating

    $ cd ~/.dotfiles
    $ git pull
    $ git submodule foreach git pull origin master

## zsh
For zsh configuration create the following symlinks:

	ln -s ~/.dotfiles/zshrc ~/.zshrc
    ln -s ~/.dotfiles/.zsh ~/.zsh
    ln -s ~/.dotfiles/zshenv ~/.zshenv
		
	
## Vim
For Vim configuration and use, create the following symlinks:

    ln -s ~/.dotfiles/vimrc ~/.vimrc
    ln -s ~/.dotfiles/vim ~/.vim
    ln -s ~/.dotfiles/gvimrc ~/.gvimrc

Vim's backup and swap files are stored in `~/.tmp`, so that directory must exist. To be sure run:

    $ touch ~/.tmp

Recipe for cloning Vim configuration to a machine, including git submodule init and update for
Vim bundles:

    $ cd ~
    $ git clone http://github.com/zan5hin/dotfiles.git ~/.dotfiles
    $ ln -s ~/.dotfiles/vimrc ~/.vimrc
    $ ln -s ~/.dotfiles/vim ~/.vim
    $ mkdir ~/.tmp
    $ cd ~/.dotfiles
    $ git submodule init
    $ git submodule update

Upgrade a single Vim bundle:

    $ cd ~/.dotfiles/vim/bundle/fugitive
    $ git pull origin master

Upgrade all Vim bundles:

    $ cd ~/.dotfiles
    $ git submodule foreach git pull origin master

## bash
For those machines where zsh isn't installed or won't easily work, create the
following symlinks:

    $ ln -s ~/.dotfiles/bash_profile ~/.bash_profile
    $ ln -s ~/.dotfiles/bashrc ~/.bashrc
    $ ln -s ~/.dotfiles/bash_aliases ~/.bash_aliases
    $ ln -s ~/.dotfiles/bash_history ~/.bash_history

## Git
For Git configuration and global ignore files, create these symlinks:

    $ ln -s ~/.dotfiles/gitconfig ~/.gitconfig
    $ ln -s ~/.dotfiles/gitignore_global ~/.gitignore_global

NB: For machines where Sublime Text 2 cannot be installed, link `gitconfig_remote` instead. This will use vim as the editor and vimdiff as the merge and diff tools.

## Mercurial (hg)
For Mercurial configuration and global ignore files, create these symlinks:

    $ ln -s ~/.dotfiles/hgrc ~/.hgrc
    $ ln -s ~/.dotfiles/hgignore_global ~/.hgignore_global
	
Also, the Steve Losh hg-prompt project is needed. Ensure that there is a `${HOME}/Projects/hg` directory, and clone the hg-prompt project to that location.

    $ hg clone http://bitbucket.org/sjl/hg-prompt/
	
Once the hg-prompt clone is complete, edit the `.hgrc` to make sure that the following line is present:

    [extensions]
    prompt = ${HOME}/Projects/hg/hg-prompt/prompt.py

## TextMate (mate)
For TextMate 2 settings create the following symlink:

    $ ln -s ~/.dotflles/tm_properties ~/.tm_properties

## tmux (terminal multiplexer) configuration
For tmux configuration create this symlink:

    $ ln -s ~/.dotfiles/tmux.conf ~/.tmux.conf

## Sublime Text 2 (subl)
Install Package Control following the instructions here: http://wbond.net/sublime_packages/package_control

For Sublime Text 2 settings remove the following directory from 
`~/Library/Application Support/Sublime Text 2`:

    Packages/User

Then add this symlink:

    $ cd ~/Library/Application\ Support/Sublime\ Text\ 2
    $ ln -s ~/.dotfiles/User ./Packages/User

Finally, to enable the hidden command line tool `subl` add this symlink:

    $ ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

##z
To enable z directory function from https://github.com/rupa/z :

	$ git submodule init
	
If not already present in `.zshrc` add:

    source ${HOME}/.dotfiles/z/z.sh
	
To update z:

    $ cd ~/.dotfiles/z
    $ git pull origin master

z will also be updated when all other git submodules are updated via:

    $ cd ~/.dotfiles
    $ git submodule foreach git pull origin master
