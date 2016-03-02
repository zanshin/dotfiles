#!/usr/bin/env bash

#
# This script creates symlinks for desired dotfiles in the users home diretory.
#

# Variables
dotfiles_dir=~/.dotfiles
dirs="bash gem git openconnect tmux"

# Update dotfiles to master branch
echo "Updating $dotfiles_dir to master"
cd $dotfiles_dir;
git pull origin master;
cd;

echo ""

function makeLinks() {
  # For each directory in dirs, make a symlink for each file found that starts
  # with a . (dot)
  for dir in $dirs; do
    echo "Linking $dir files"
    cd $dotfiles_dir/$dir;
    for file in *; do
      ln -svf $dotfiles_dir/$dir/$file ~/.$file
    done
    echo ""
  done

  # Handle odd-ball cases
  # Vim files¬
  echo "Linking vim files"
  ln -svf $dotfiles_dir/vim ~/.vim;
  ln -svf $dotfiles_dir/vim/vimrc ~/.vimrc;
  ln -svf $dotfiles_dir/vim/vimrc.bundles ~/.vimrc.bundles;

  # ssh
  echo ""
  echo "Linking ssh configuration."
  ln -svf $dotfiles_dir/ssh/config ~/.ssh/config

  # i3
  echo ""
  echo "Linking i3 configuration."
  ln -svf $dotfiles_dir/.i3 ~/.i3

  echo ""
  echo "Caveats:"
  echo "Vim:  If remote server, rm .vimrc.bundles"
  echo "Bash: If local server, rm .bashrc.local"

  echo ""

  echo "Finished."
}

if [ "$1" == "--force" -o "$1" == "-f" ]; then
  makeLinks;
else
  read -p "This may overwrite existing files in your home directory. Are you sure? (y/n) " -n 1;
  echo ""
  if [[ $REPLY =~ ^[Yy]$ ]]; then
    makeLinks;
  fi;
fi;
unset makeLinks;
