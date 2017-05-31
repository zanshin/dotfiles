#!/usr/bin/env bash
set -e

ask() {
  # https://djm.me/ask
  local prompt default reply

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

    # Ask the question (not using "read -p" as it uses stderr not stdout)
    echo -n "$1 [$prompt] "

    # Read the answer (use /dev/tty in case stdin is redirected from somewhere else)
    read reply </dev/tty

    # Default?
    if [ -z "$reply" ]; then
      reply=$default
    fi

    # Check if the reply is valid
    case "$reply" in
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
      ln -sf $dotfiles_dir/$dir/$file ${HOME}/.$file
    done
  fi
  echo ""
done

# Setup Neovim (nvim)
# need 'n' flag on ln statement, since we're linking a directory
if ask "Setup Neovim (nvim)" Y; then
  echo "Linking Neovim (nvim) files"
  cd $dotfiles_dir/nvim;
  mkdir -p ${HOME}/.config
  ln -sfn $dotfiles_dir/nvim ${HOME}/.config/nvim;
fi
echo ""

# Setup Vim
if ask "Setup Vim" Y; then
  echo "Linking Vim files"
  cd $dotfiles_dir/vim;
  ln -sf $dotfiles_dir/vim ${HOME}/.vim;
  ln -sf $dotfiles_dir/vim/vimrc ${HOME}/.vimrc;
  ln -sf $dotfiles_dir/vim/vimrc.bundles ${HOME}/.vimrc.bundles;
fi
echo ""

# Setup ssh
if ask "Setp ssh config" Y; then
  echo "Linking ssh config"
  ln -sf $dotfiles_dir/ssh/config ${HOME}/.ssh/config
fi

echo ""
echo "Caveats:"
echo "Vim: if remote server, rm .vimrc.bundles"
echo "Bash: if local machine, rm .bashrc.local"

echo ""
echo "Finished."
