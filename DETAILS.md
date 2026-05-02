# Configuration Details

This file details each of the tools for which I keep configuration files under version
control. For information on installing the configuration files, please see the main [README](README.markdown).

## Alacritty
This is unused except on rare occasions. 

## Ayu
This is a fork of the Ayu Dark them for Blink. Blink is a terminal emulator for
iOS.

## bash
I have organized my bash configuration around individual files for exports,
paths, functions, and aliases. The `.bash-profile` only sources
`.bashrc`. This means that I get the same configuration whether I'm in an interactive,
non-interactive, login, or non-login shell.

`.bashrc` sources everything else. The files containing aliases, functions,
 exports, and the path configuration, are now all stored in `~/.config/bash.d`. This simplifies the file listing of `$HOME`, as the are only three bash files there now, `.bash_profile`, `.bashrc`, and `.bash_history`.

To manually install this bash configuration, create the following symlinks.

    $ ln -s ~/.dotfiles/bash/bash_profile ~/.bash_profile
    $ ln -s ~/.dotfiles/bash/bashrc ~/.bashrc
    $ ln -s ~/.dotfiles/bash/bash.d ~/.config/bash.d

## Homebrew
On those macOS machines where I install Homebrew I also edit `/etc/paths` to move the `/usr/local/bin` entry to the top of the list. This ensures that Homebrew-managed programs and libraries occur prior to `/usr/bin` and system-provided programs and libraries. The resulting `/etc/paths` files looks like this:

    /usr/local/bin
    /usr/bin
    /bin
    /usr/sbin
    /sbin

The `~/.dotfiles/brew/Brewfile` acts as a bundle for Homebrew. Use `brew bundle ~/.dotfiles/brew/Brewfile` to set up brews.

## Gem
In order to prevent `gem install` or `gem update` from downloading RDoc and RI, symlink this file.

    $ ln -s ~/.dotfiles/gem/gemrc ~/.gemrc

## Ghostty
My current terminal of choice. Nice minimal configuration.

## Git
For Git configuration and global ignore files, create these symlinks:

    $ ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
    $ ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global

## GnuPG
My GPG configuration, with lots of comments to remind me what is what.

## Jujutsu or jj
I have started using [Jujutsu](https://docs.jj-vcs.dev/latest/) for version
 contol. The `jj` directory holds my Jujutsu configuration.

## Kitty
Yet another terminal emulator.

## ssh
For ssh configuration, create the following symlink:

    ln -s ~/.dotfiles/ssh/config ~/.ssh/config

## Neovim (nvim)
For Neovim configuration, create the following symlink:

    ln -sn ~/.dotfiles/nvim ~/.config/nvim

The `n` flag on the `ln` command treats directories as files when making the link. This prevents the link command from nesting the destination under an already existing directory.

The configuration is loosely based off [kickstart.nvim](https://github.com/nvim-lua/kickstart.nvim), with the plugins I use, and my preferred mappings and options.

## tmux (terminal multiplexer) configuration
For tmux configuration create this symlink:

    $ ln -s ~/.dotfiles/tmux/tmux.conf ~/.tmux.conf


## mutt
The mutt directory contains the configuration for my mutt setup. Do not blindly copy these and use them.
Really.

