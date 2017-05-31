#!/usr/bin/env bash

set -e
ask() {
  while true; do
    if [ "${2:-}" = "Y" ]; then
      prompt="Y/n"
      default=Y
    elif [ "${2:-}" = "N" ]; then
      prompt="y/N"
      default=N
    else
      prompt="y/n"
      default=
    fi
    read -p "$1 [$prompt] " REPLY </dev/tty
    if [ -z "$REPLY" ]; then
      REPLY=$default
    fi
    case "$REPLY" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac
  done
}

dotfiles_dir=~/.dotfiles

# Update dotfiles to master branch
echo "Updating $dotfiles_dir to master"
cd $dotfiles_dir;
git pull origin master;
cd;

echo ""

# Build key,value pairs of the tool and whether or not to install it
# each tuple lists a directory and its install flag
tuples="bash,Y gem,Y git,Y openconnect,Y tmux,Y slate,Y hg,N textmate,N"

# For these directories, create symlinks for each file present
# By passing the ask function `Y` we default to creating these
# By passing the ask function `N` we default to not creating these
for pair in $tuples; do
  dir=${pair%,*};
  flag=${pair#*,};
  if ask "Setup $dir" $flag; then
    echo "Linking $dir files"
    cd $dotfiles_dir/$dir;
    for file in *; do
      ln -svf $dotfiles_dir/$dir/$file ${HOME}/.$file
    done
  fi
done

# Setup Neovim (nvim)
if ask "Setup Neovim (nvim)" Y; then
  echo "Linking Neovim (nvim) files"
  cd $dotfiles_dir/nvim;
  mkdir -p ${HOME}/.config
  ln -sfn $dotfiles_dir/nvim ${HOME}/.config/nvim;
fi

# Setup Vim
if ask "Setup Vim" Y; then
  echo "Linking Vim files"
  cd $dotfiles_dir/vim;
  ln -svf $dotfiles_dir/vim ${HOME}/.vim;
  ln -svf $dotfiles_dir/vim/vimrc ${HOME}/.vimrc;
  ln -svf $dotfiles_dir/vim/vimrc.bundles ${HOME}/.vimrc.bundles;
fi

# Setup ssh
if ask "Setp ssh config" Y; then
  echo "Linking ssh config"
  ln -svf $dotfiles_dir/ssh/config ${HOME}/.ssh/config
fi

echo ""
echo "Caveats:"
echo "Vim: if remote server, rm .vimrc.bundles"
echo "Bash: if local machine, rm .bashrc.local"

echo ""
echo "Finished."
