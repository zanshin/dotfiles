-- Neovim Configuration file - Lua version
--

-- Some helpers
local cmd = vim.cmd   -- to execute Vim commands e.g., cmd('pwd')
local fn = vim.fn     -- to call Vim functions e.g., fn.bufnr()
local g = vim.g       -- a table to access global variables
local opt = vim.opt   -- to set options

-- No idea what this does. Copy/pasted from elsewhere
local function map(mode, lhs, rhs, opts)
  local options = {noremap = true}
  if opts then
    options = vim.tbl_extend("force", options, opts)
  end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

-- Map leader to space
g.mapleader = " "

-- Plugins
require "paq-nvim" {
  "airblade-gitgutter",                   -- Git helper
  "glepnir/lspsaga.nvim",
  "hoob3rt/lualine.ncim",                 -- Lua based status bar
  "neovim/nvim-lspconfig",                -- LSP configuration
  "nvim-telescope/telescope.nvim",
  "nvim-treesitter/nvim-treesitter",      -- Syntax highlighting
  "ayu-theme/ayu-vim",                    -- ayu theme
  "sjl/gundo.vimn",                       -- Undo improvements
  "scrooloose/nerdtree", {'on': 'NERDTreeToggle' }

  -- Appearance
  "itchyny/lightline.vim"
  "ayu-theme/ayu-vim"

  -- Syntax
  "Yggdroot/indentline"
  "stephpy/vim-yaml"
  "Xuyuanp/nerdtree-git-plugin"
  "hashivim/vim-terraform"

  -- Git helpers
Plug 'tpope/vim-fugitive'
Plug 'airblade/vim-gitgutter'
Plug 'Xuyuanp/nerdtree-git-plugin'

" Utilities
Plug 'sjl/gundo.vim'
Plug 'scrooloose/nerdtree', { 'om': 'NERDTreeToggle' }
Plug 'tpope/vim-surround'
Plug 'tomtom/tcomment_vim'
Plug 'jiangmiao/auto-pairs'

" Go Language
Plug 'fatih/vim-go', { 'do': ':GoUpdateBinaries' }
Plug 'sebdah/vim-delve'

" EditConfig
Plug 'editorconfig/editorconfig-vim'

" Language Server Protocol (LSP)
Plug 'autozimu/LanguageClient-neovim', { 'branch': 'next', 'do': 'bash install.sh' }

" Rust Language
Plug 'cespare/vim-toml'

" Neovim stuff
Plug 'kassio/neoterm'

" Ansible
Plug 'pearofducks/ansible-vim'



}
