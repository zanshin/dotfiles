# Introduction

My dotfiles rely on using Base16 for colors and theming. The readme outlines the steps necessary to
set Base16 up, and integrate it so that everything works. This is an opinionated setup.

## Required

* [Base16](https://github.com/chriskempson/base16)
* [Base16-vim](https://github.com/chriskempson/base16-vim)
* [Base16-shell](https://github.com/chriskempson/base16-shell)
* [Neovim](https://neovim.io)
* [Bash](https://www.gnu.org/software/bash/)

## Installation

Base16's component parts are all available on Github, and their respective repositories have
installation directions. Here's a brief recap.

**base16**
This isn't required to use Base16, but it does provide documentation. I keep such things in my
`~/src` directory.

    cd ~/src
    git clone https://github.com/chriskempson/base16.git

**base16-vim**
This repository contains the base16 color themes for (Neo)vim. It gets installed as a plugin. Using
Vim-Plug, that looks like this:

    Plug 'chriskempson/base16-vim'

After adding the `Plug` command, run `:PlugUpdate` to install the plugin. The payload ends up in `~/.config/nvim/plugged/base16`.

**base16-shell**
This repository provides shell scripts that execute the escape codes necessary to change the colors
used by iTerm2. (I don't know how this works for Apple Terminal.)

    git clone https://github.com/chriskempson/base16-shell.git ~/.config

**Neovim**
The Neovim site provides instructions on installing and configuring Neovim. That activity is beyond
the scope of this readme.

**Bash**
I'm using bash version 4.4.1. Find the latest release for your operating system and install it.

## Configuration
This base16 setup relies upon two files located in `$HOME`:

    .base16
    .nvim_theme

The first holds the current color scheme for the shell, and the second holds the current color
scheme for Neovim. Both of these are set and controlled by a bash function called `color`.

The `color()` function in `bash/bash_functions` has four runtime options:

    color
    color help
    color default
    color <base16-scheme>

`color` by itself shows the current color scheme selected, i.e., the contents of `$HOME/.base16`.
`color help` gives an example of running the function and lists all the currently installed themes.
`color default` sets the active theme to my default, which is currently `chalk`. Finally, `color
<base16-scheme>` changes the current color scheme to the input value.

When the function does the switch it

* Executes the base16-shell script to change the Terminal colors
* Updates the scheme name stored in `$HOME/.base16`
* Updates the color scheme in `$HOME/.nvim_theme`

The function has several variables that can be set to where various dependencies are installed.


**(Neo)vim configuration**
While it would be nice to have Neovim automatically update the color scheme in any open sessions
when the color is changed outside of Neovim, that isn't currently functioning. The code I have
depends upon the `FocusGained` autocommand event, which is

> [o]nly for the GUI version and a few console versions where this can be detected.

Turns out iTerm2 doesn't pass that event on to either Vim or Neovim. Consequently I have a mapping
that sources `$HOME/.nvim_theme`, and I use that file to set the color whenever Neovim is started.

    if filereadable(expand("~/.nvim_theme"))
      let base16colorspace=256
      source ~/.nvim_theme
    endif

    nnoremap <leader>c :source ~/.nvim_theme<CR>

The file being sourced has this content:

    if !exists('g:colors_name') || g:colors_name != 'base16-chalk'
      colorscheme base16-chalk
    endif

If I want to synchronize Neovim's colorscheme with the current shell theme, a quick `<leader>c` does
the trick.




