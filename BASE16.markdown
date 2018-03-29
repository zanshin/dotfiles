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

The payload ends up in `~/.config/nvim/plugged/base16`.

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
With the base16 components installed you can execute a color script from base16-shell to alter the
terminal colors. You can also edit your Neovim `init.vim` and change the `colorscheme` setting to
match.

Or, you can use a bash function to change the color scheme. This is advantageous in that the
function can be run from any command prompt, with out needing the full path to the appropriate color
shell script.

The `color()` function in `bash/bash_functions` does just that. The function has several variables
that allow for changing where components are installed, and to set a default color.

This function also updates a small file that is sourced by (Neo)vim to set the colorscheme there.
This file looks like this:

    if !exists('g:colors_name') || g:colors_name != 'base16-chalk'
      colorscheme base16-chalk
    endif

**(Neo)vim configuration**
Updating a file that is sourced to change the colorscheme in Neovim works for new sessions. If you
want active sessions to change, the same way the terminal changes, some addition work is required.

    function s:CheckColorScheme()

      colorscheme base16-default-dark
      "if filereadable(expand("~/.vimrc_background"))
      " if filereadable(expand("~/.config/nvim/.nvim_background"))
      if filereadable("~/.config/nvim/.nvim_background")
        let base16colorspace=256
        source ~/.config/nvim/.nvim_background
      endif
    endfunction

    if has('autocmd')
      augroup MyAutocolor
        autocmd!
        autocmd FocusGained * call s:CheckColorScheme()
      augroup END
    endif

When Neovim regains focus (`FocusGained`) it triggers the CheckColorScheme function, which set the
colorscheme to be used.



