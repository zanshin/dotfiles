# Neovim Configuration

## Background
I've been using some form of vi/vim/neovim since 1997. Around 2008, when I started using Octopress
for my website, I started customizing vim setup. The oldest commit in my dotfiles repository that
mentions vim is from November 14, 2011. The initial neovim commit is from December 17, 2015. For a
while I maintained both a vim and a neovim configuration, but over time the vim configuration
became stale as it was no longer being maintained.

Over the past few weeks I have been working on converting my Neovim configuration to use Lua. A
number of resources helped me in that endeavor, they are listed in the appendix below.

## Prerequisites

* Neovim 0.6.*x or later
* Node - Several of the language servers I have setup require Node
* A "hacked" font

### JetBrains Mono Nerd font
For MacOS:

* brew tap homebrew/cask-fonts
* brew install --cask font-jetbrains-mono-nerd-font

## Organization
The configuration is organized into separate files. My previous Neovim configuration was monolithic
and was roughly 1000 lines of code. The Lua-base configuration has nearly 40 files, spread across 8
directories. Modular rather than monolithic. Currently the configuration totals about 1450 lines of
Lua code, excluding comments and white space.

### Directory Structure
At the root of my Neovim directory is the `init.lua` file. This file has a list of requires that
source the pieces of my configuration. These pieces are:

    autocmds
    colors
    helpers
    mappings
    options
    plugins

These files are all named spaced under the `lua/usr` directory to prevent potential collisions with
plugins.

The configuration files for the plugins are all under the `lua/config` directory. There is also a
separate directory for the language server configuration files.

## Plug Ins
The list of plugins is constantly changing, but the core plugins that I have installed are:

* cmp - Completion
* gitsigns -
* gundo -
* lualine - status bar
* nvim-comment - toggle comments on or off
* nvim-tree - file explorer
* tabline - tab and buffer status line that integrates with lualine
* telescope - fuzzy finder
* toggleterm - wrapper around terminal display within neovim
* treesitter - abstract symbol tree tool used for code syntax operations
* which-key - popup command Completion

## appendix
These are some of the sources I used while converting from a vimscript based configuration to a Lua
based configuration.

* [https://oroques.dev/notes/neovim-init/](https://oroques.dev/notes/neovim-init/)
*
