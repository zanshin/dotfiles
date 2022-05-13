# Neovim Configuration

## Background
I've been using some form of Vi/Vim/Neovim since 1997. Around 2008, when I started using Octopress
for my website, I started customizing my Vim setup. The oldest commit in my dotfiles repository that
mentions Vim is from November 14, 2011. The initial Neovim commit is from December 17, 2015. For a
while I maintained both a Vim and a Neovim configuration, but over time the Vim configuration
became stale as it was no longer being maintained.

Beginning in late 2021 I began converting my Neovim configuration to use Lua. A
number of resources helped me in that endeavor, they are listed in the appendix below.

## Prerequisites

* Neovim 0.8.*x or later
* Node - Several of the language servers I have setup require Node
* A "hacked" font

### JetBrains Mono Nerd font
For MacOS:

* brew tap homebrew/cask-fonts
* brew install --cask font-jetbrains-mono-nerd-font

## Organization
The configuration is organized into separate files. My previous Neovim configuration was monolithic
and had roughly 1000 lines of code. The Lua-based configuration has nearly 40 files, spread across 8
directories—modular rather than monolithic. Currently the configuration totals about 1450 lines of
Lua code, excluding comments and white space.

### Directory Structure
At the root of my Neovim directory is the `init.lua` file. This file has a list of requires that
source the pieces of my configuration. These files are all named spaced under the `lua/usr`
directory to prevent potential collisions with plugins.

    autocmds
    colors
    helpers
    mappings
    options
    plugins


The configuration files for the plugins are all under the `lua/config` directory.

## Plug Ins
These are the core plugins that I have installed.

* [packer](https://github.com/wbthomason/packer.nvim "packer") - Plugin management
* [nvim-cmp](https://github.com/hrsh7th/nvim-cmp "nvim-cmp") - Code completion
* [gitsigns](https://github.com/lewis6991/gitsigns.nvim "gitsigns") - Visual Git activity markers
* [gundo](https://github.com/sjl/gundo.vim "gundo") - Wrapper around basic undo
* [lualine](https://github.com/nvim-lualine/lualine.nvim "lualine") - Status bar
* [nvim-comment](https://github.com/terrortylor/nvim-comment "nvim-comment") - Toggle comments on or off
* [nvim-tree](https://github.com/kyazdani42/nvim-tree.lua "nvim-tree") - File explorer
* [tabline](https://github.com/kdheepak/tabline.nvim "tabline") - Tab and buffer status line that integrates with lualine
* [telescope](https://github.com/nvim-telescope/telescope.nvim "telescope") - Fuzzy finder
* [toggleterm](https://github.com/akinsho/toggleterm.nvim "toggleterm") - Wrapper around terminal display within neovim
* [treesitter](https://github.com/nvim-treesitter/nvim-treesitter "treesitter") - Abstract symbol tree tool used for code syntax operations
* [which-key](https://github.com/folke/which-key.nvim "which-key") -key - Popup command Completion

There are dependencies and some ancillary plugins not listed here.

## Appendix
These are some of the sources I used while converting from a vimscript based configuration to a Lua
based configuration.

* [https://oroques.dev/notes/neovim-init/](https://oroques.dev/notes/neovim-init/)
* [https://github.com/rockerBOO/awesome-neovim#snippet](https://github.com/rockerBOO/awesome-neovim#snippet)
* [https://microsoft.github.io/language-server-protocol/implementors/servers/](https://microsoft.github.io/language-server-protocol/implementors/servers/)
* [https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887](https://blog.inkdrop.app/how-to-set-up-neovim-0-5-modern-plugins-lsp-treesitter-etc-542c3d9c9887)
* [https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts](https://github.com/ryanoasis/nerd-fonts#option-4-homebrew-fonts)
* [https://teukka.tech/luanvim.html](https://teukka.tech/luanvim.html)
* [https://crispgm.com/page/neovim-is-overpowering.html](https://crispgm.com/page/neovim-is-overpowering.html)
* [https://www.reddit.com/r/neovim/comments/kfxqcr/how_to_migrate_from_initvim_to_initlua/](https://www.reddit.com/r/neovim/comments/kfxqcr/how_to_migrate_from_initvim_to_initlua/)
* [https://github.com/nanotee/nvim-lua-guide/](https://github.com/nanotee/nvim-lua-guide/)
* [https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/](https://vonheikemen.github.io/devlog/tools/configuring-neovim-using-lua/)
* [https://icyphox.sh/blog/nvim-lua/](https://icyphox.sh/blog/nvim-lua/)
* [https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ](https://www.youtube.com/playlist?list=PLhoH5vyxr6Qq41NFL4GvhFp-WLd5xzIzZ)
