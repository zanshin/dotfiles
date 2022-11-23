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
    read -r reply </dev/tty

    # Default?
    if [ -z "$reply" ]; then
      reply="$default"
    fi

    # Check if the reply is valid
    case "$reply" in
      Y*|y*) return 0 ;;
      N*|n*) return 1 ;;
    esac

  done
}

dotfiles_dir=~/.dotfiles
xdg_config_home=~/.config

# Update dotfiles to master branch
echo "Updating $dotfiles_dir to master"
cd "$dotfiles_dir";
git pull origin master;
cd;

echo ""

# Build key,value pairs of the tool and whether or not to install it
# each tuple lists a directory and its install flag
tuples="gem,Y hg,N"

# For these directories, create symlinks for each file present
# By passing the ask function `Y` we default to creating these
# By passing the ask function `N` we default to not creating these
for pair in $tuples; do
  dir=${pair%,*};
  flag=${pair#*,};
  if ask "Setup $dir" "$flag"; then
    echo "Linking $dir files"
    cd "$dotfiles_dir"/"$dir";
    for file in *; do
      ln -sf "$dotfiles_dir"/"$dir"/"$file" "${HOME}"/."$file"
    done
  fi
  echo ""
done

xdg_tuples="git,Y tmux,Y nvim,Y alacritty,Y"
for pair in $xdg_tuples; do
  dir=${pair%,*};
  flag=${pair#*,};
  if ask "Setup $dir" "$flag"; then
    echo "Linking $dir into $HOME/.config"
    mkdir -p "$xdg_config_home";
    ln -sf "$dotfiles_dir"/"$dir" "$xdg_config_home"/"$dir"
  fi
  echo ""
done

# # Setup git in $XDG_CONFIG_HOME
# if ask "Setup git" Y; then
#   echo "Setting up git config files"
#   ln -sf "$dotfiles_dir"/git/config "$xdg_config_home"/git/config;
#   ln -sf "$dotfiles_fir"/git/ignore "$xdg_config_home"/git/ignore;
# fi
# echo ""

# Setup tmux
# Since version 3.1, tmux has supprted $XDG_CONFIG_HOME/tmux/tmux.conf
# if ask "Setup tmux" Y; then
#   echo "Setting up tmux config file"
#   mkdir -p "$xdg_config_home"
#   ln -sf "$dotfiles_dir"/tmux/ "$xdg_config_home"/tmux;
# fi
# echo ""

# Setup Starship prompt
if ask "Setup Starship" Y; then
  echo "Setting up Starship prompt"
  ln -sf "$dotfiles_dir"/starship/starship.toml "$xdg_config_home/starship.toml"
fi
echo ""

# Setup Bash
if ask "Setup Bash" Y; then
  echo "Setting up bash startup files"
#  cd "$dotfiles_dir"/bash;
  ln -sfn "$dotfiles_dir"/bash/bash.d "${HOME}"/.config/bash.d;
  ln -sf "$dotfiles_dir"/bash/bashrc "${HOME}"/.bashrc;
  ln -sf "$dotfiles_dir"/bash/bash_profile "${HOME}"/.bash_profile;
fi
echo ""

# Setup Neovim (nvim)
# need 'n' flag on ln statement, since we're linking a directory
# if ask "Setup Neovim (nvim)" Y; then
#   echo "Linking Neovim (nvim) files"
#   cd "$dotfiles_dir"/nvim;
#   mkdir -p "${HOME}"/.config
#   ln -sfn "$dotfiles_dir"/nvim "${HOME}"/.config/nvim;
# fi
# echo ""

# Setup Vim
if ask "Setup Vim" N; then
  echo "Linking Vim files"
  cd "$dotfiles_dir"/vim;
  ln -sf "$dotfiles_dir"/vim "${HOME}"/.vim;
  ln -sf "$dotfiles_dir"/vim/vimrc "${HOME}"/.vimrc;
  ln -sf "$dotfiles_dir"/vim/vimrc.bundles "${HOME}"/.vimrc.bundles;
fi
echo ""

# Setup ssh
if ask "Setp ssh config" Y; then
  echo "Linking ssh config"
  ln -sf "$dotfiles_dir"/ssh/config "${HOME}"/.ssh/config
fi

echo ""
echo "Caveats:"
echo "Vim: if remote server, rm .vimrc.bundles"
# echo "Bash: if local machine, rm .bashrc.local"

echo ""
echo "Finished."
