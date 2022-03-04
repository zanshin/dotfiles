-- Parker plugin manager

-- helper function for plugin configurations
function get_config(name)
  return string.format("require(\"config/%s\")", name)
end

-- Automatically install packer.nvim
local fn = vim.fn
local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
if fn.empty(fn.glob(install_path)) > 0 then
  PACKER_BOOTSTRAP = fn.system {
    'git',
    'clone',
    '--depth',
    '1',
    'https://github.com/wbthomason/packer.nvim',
    install_path,
  }
  print "Installing Packer, close and reopen Neovim."
  vim.cmd [[packadd packer.nvim]]
end

-- Autocommand to reload neovim when the plugins.lua file is saved
vim.cmd [[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile> | PackerSync
  augroup end
]]

return require('packer').startup({ function(use)
-- packer.startup({ function()
  --  Use Packer to manage itself
  use {
    'wbthomason/packer.nvim' --, opt = true
  }

  -- Colorscheme
  use {
    'pacokwon/onedarkhc.vim',
    -- event = 'VimEnter'
  }

  -- Snazzy glyphs
  use {
    'kyazdani42/nvim-web-devicons',
    -- event = 'VimEnter',
  }

  -- Lualine
  use {
    'nvim-lualine/lualine.nvim',
    config = get_config('lualine'),
    -- event = 'VimEnter',
    -- requires = {'kyazdani42/nvim-web-devicons', opt = true}
    requires = {'kyazdani42/nvim-web-devicons' },
  }

  -- Tabline
  use {
    'kdheepak/tabline.nvim',
    config = get_config('tabline')
  }

  -- Syntax
  use { 'Yggdroot/indentline' }
  use { 'stephpy/vim-yaml' }
  use { 'hashivim/vim-terraform' }

  -- Git helpers
  -- use {
  --   'lewis6991/gitsigns.nvim',
  -- --  config = get_config('gitsigns'),
  --   requires = { 'nvim-lua/plenary.nvim' }
  -- }

  use {
    'tpope/vim-fugitive',
    config = get_config('fugitive')
  }

  use { 'airblade/vim-gitgutter' }

  -- -- Utilities
  use {
    'sjl/gundo.vim',
    config = get_config("gundo")
  }

  use { 'tpope/vim-surround' }
  use { 'tomtom/tcomment_vim' }
  use { 'jiangmiao/auto-pairs' }
  use { 'tweekmonster/startuptime.vim' }

  -- Go Language
--  use { 'fatih/vim-go', run = ':GoUpdateBinaries' }

  -- EditConfig
  use { 'editorconfig/editorconfig-vim' }

  --
  -- Language Server Protocol (LSP)
  use {
    'neovim/nvim-lspconfig',
    config = get_config('lspconfig')
  }

  use { 'b0o/schemastore.nvim' }
  use {
    'RRethy/vim-illuminate',
    config = get_config("illuminate")
  }

  -- -- Rust Language
  use { 'cespare/vim-toml' }

  --
  -- -- Neovim stuff
  use { 'kassio/neoterm' }

  -- Ansible
  use { 'pearofducks/ansible-vim' }

  -- Telescope
  use {
    'nvim-telescope/telescope.nvim',
    requires = {{"nvim-lua/popup.nvim"}, {"nvim-lua/plenary.nvim"}},
    config = get_config("telescope")
  }

  -- -- Treesitter
  -- use { 'nvim-treesitter/nvim-treesitter' }
  -- use { 'nvim-treesitter/playground' }

  -- Completion
  use { 'hrsh7th/nvim-cmp' }
  use { 'hrsh7th/cmp-buffer' }
  use { 'hrsh7th/cmp-path' }
  use { 'hrsh7th/cmp-nvim-lua' }
  use { 'hrsh7th/cmp-nvim-lsp' }

  use { 'onsails/lspkind-nvim' }

  -- -- Nvim-tree
  -- -- use { 'kyazdani42/nvim-web-devicons' }
  -- use { 'kyazdani42/nvim-tree.lua' }

  if packer_bootstrap then
    require('packer').sync()
  end
end,

config = {
  display = {
    open_fn = function()
      return require('packer.util').float({border = 'single' })
    end
  }
}
})

