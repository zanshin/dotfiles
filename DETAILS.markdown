# Configuration Details

This readme file details each of the tools I keep versioned configuration file for. For
information on installing the configuration files, please see the [README](README.markdown).

## Homebrew
On those macOS machines where I install Homebrew I also edit `/etc/paths` to move the `/usr/local/bin` entry to the top of the list. This ensures that Homebrew-managed programs and libraries occur prior to `/usr/bin` and system-provided programs and libraries. The resulting `/etc/paths` files looks like this:

    /usr/local/bin
    /usr/bin
    /bin
    /usr/sbin
    /sbin

The `~/.dotfiles/brew/Brewfile` acts as a bundle for Homebrew. Use `brew bundle ~/.dotfiles/brew/Brewfile` to set up brews.

## bash
For those machines where zsh isn't installed or won't easily work, create the
following symlinks:

    $ ln -s ~/.dotfiles/bash/bash_profile ~/.bash_profile
    $ ln -s ~/.dotfiles/bash/bashrc ~/.bashrc
    $ ln -s ~/.dotfiles/bash/bash_aliases ~/.bash_aliases
    $ ln -s ~/.dotfiles/bash/bash_colors ~/.bash_colors
    $ ln -s ~/.dotfiles/bash/bash_bindkeys ~/.bash_bindkeys
    $ ln -s ~/.dotfiles/bash/bashrc.local ~/.bashrc.local

The `.bashrc.local` file contains configurations only needed on the remote servers I manage.
Therefore this file is only linked on those remote machines.

## zsh - No longer maintained
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

On remote servers where the Vim version maybe older or not under my control, eliminate the
`.vimrc.bundles` symlink. All bundles and their settings are encapsulated in this file. The `.vimrc`
file will default the color scheme and spelling dictionary settings if `.vimrc.bundles` is not
found.

To install vim-plug managed plugins run the following command from within Vim:

    :PlugInstall

To install vim-plug run the following command:

    curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \
    https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim

## Neovim (nvim)
For Neovim configuration, create the following symlink:

    ln -sn ~/.dotfiles/nvim ~/.config/nvim

The `n` flag on the `ln` command treats directories as files when making the link. This prevents the
link command from nesting the destination under an already existing directory.

Neovim also uses Vim-Plug. See the Vim-Plug notes in the Vim section above.

## Git
For Git configuration and global ignore files, create these symlinks:

    $ ln -s ~/.dotfiles/git/gitconfig ~/.gitconfig
    $ ln -s ~/.dotfiles/git/gitignore_global ~/.gitignore_global

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

My tmux configuration doesn't alwasy work on Linux - depending the the distro being used. The
`tmux.linux` file is an alternate tmux configuration that can be linked on Linux. It isn't well
maintained.

## Sublime Text 2 (subl)
Install Package Control following the instructions here: http://wbond.net/sublime_packages/package_control

For Sublime Text 2 settings, remove the `User` directory from
`~/Library/Application Support/Sublime Text 2/Packages`. Then add this symlink:

    $ cd ~/Library/Application\ Support/Sublime\ Text\ 2/Packages
    $ ln -s ~/.dotfiles/sublimetext/User User

Finally, to enable the command line tool, `subl`, add this symlink:

    $ ln -s /Applications/Sublime\ Text\ 2.app/Contents/SharedSupport/bin/subl /usr/local/bin/subl

## OpenConnect
An alternative to using Cisco's AnyConnect.

Requires that `openconnect` be installed via Homebrew and that TUN/TAP for OS X be installed. See http://zanshin.net/2013/08/27/setup-openconnect-for-mac-os-x-lion/
for details.

    $ ln -s ~/.dotfiles/openconnect/openconnect ~/.openconnect

## i3
The beginnings of an i3 window manager configuration. Originally setup on Debian, now used on Ubuntu
16.

    ln -s ~/.dotfiles/i3/config ~/.i3/config

## config
The $XDG_CONFIG_HOME location (as far as I know) is `$HOME/.config`. On Linux, and increasingly on
macOS, tools are placing their configurations under `~/.config`. At present have font, polybar, and
i3 configurations for Arch and Antergos stored in this directory. The Neovim configuration lives in
$XDG_CONFIG_HOME/nvim, but I keep it separately in this repository.

## mutt and mutt-deprecated
I have threatened to use mutt for email more than once. These two directories contain the
configurations that resulted from these experiements. Do not blindly copy these and use them.
Really. 

## ohmyzsh
This is how I got introduced to zsh. I haven't used or updated this configuration in a very long
time. Do a search for `onmyzsh` and follow the directions you find there rather than using my
ancient, crufy, setup.

## scripts
These are some tmux setup scripts that I use. Highly personalized. 

## slate
Slate is a macOS window manager. This is my configuration for it.


