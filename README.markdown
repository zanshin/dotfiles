This repository holds my configuration files so that I can clone them to other machines
easily.

Installation:

    git clone git://github.com/zan5hin/dotfiles.git ~/.dotfiles

Create the following symlinks:

    ln -s ~/.dotfiles/vimrc ~/.vimrc
    ln -s ~/.dotfiles/vim ~/.vim
    ln -s ~/.dotfiles/zshrc ~/.zshrc

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


