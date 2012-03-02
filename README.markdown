This repository holds my configuration files so that I can clone them to other machines
easily.

##Installation:

    git clone git://github.com/zan5hin/dotfiles.git ~/.dotfiles
	
## zsh
	For zsh configuration create the following symlink:

	    ln -s ~/.dotfiles/zshrc ~/.zshrc
		
	Clone on-my-zsh repository from Github:
	
	    git clone git://github.com/robbyrussell/oh-my-zsh.git ~/.oh-my-zsh
		
	Copy zanshin.zsh-theme to theme directoy
	
	    cd .oh-my-zsh/themes
		ln -s ~/.dotfiles/zanshin.zsh-theme zanshin.zsh-theme
	

## Updating

    cd ~/.dotfiles
    git pull
    git submodule foreach git pull origin master

## Vim
For Vim configuration and use, create the following symlinks:

    ln -s ~/.dotfiles/vimrc ~/.vimrc
    ln -s ~/.dotfiles/vim ~/.vim

Vim's backup and swap files are stored in `~/.tmp`, so that directory must exist. To be sure run:

    mkdir ~/.tmp

Recipe for cloning to a machine, including git submodule init and update for
Vim bundles:

    cd ~
    git clone http://github.com/zan5hin/dotfiles.git ~/.dotfiles
    ln -s ~/.dotfiles/vimrc ~/.vimrc
    ln -s ~/.dotfiles/vim ~/.vim
    ln -s ~/.dotfiles/zshrc ~/.zshrc
    mkdir ~/.tmp
    cd ~/.dotfiles
    git submodule init
    git submodule update

Upgrade a single Vim bundle:

    cd ~/.dotfiles/vim/bundle/fugitive
    git pull origin master

Upgrade all Vim bundles:

    cd ~/.dotfiles
    git submodule foreach git pull origin master

## bash
For those machines where zsh isn't installed or won't easily work, create the
following symlinks:

    ln -s ~/.dotfiles/bash_profile ~/.bash_profile
    ln -s ~/.dotfiles/bashrc ~/.bashrc
    ln -s ~/.dotfiles/bash_aliases ~/.bash_aliases
    ln -s ~/.dotfiles/bash_history ~/.bash_history

## Git
For Git configuration and global ignore files, create these symlinks:

    ln -s ~/.dotfiles/gitconfig ~/.gitconfig
    ln -s ~/.dotfiles/gitignore_global ~/.gitignore_global

## Mercurial (hg)
For Mercurial configuration and global ignore files, create these symlinks:

    ln -s ~/.dotfiles/hgrc ~/.hgrc
    ln -s ~/.dotfiles/hgignore_global ~/.hgignore_global

## TextMate (mate)
For TextMate 2 settings create the following symlink:

    ln -s ~/.dotflles/tm_properties ~/.tm_properties

