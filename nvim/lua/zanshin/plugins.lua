return {

  -- Dependencies
  'nvim-lua/plenary.nvim',
  'nvim-lua/popup.nvim',
  'kyazdani42/nvim-web-devicons',
  'MunifTanjim/nui.nvim',

  -- Colorscheme
  'Shatur/neovim-ayu',

  -- Snazzy glyphs
  'kyazdani42/nvim-web-devicons',

  -- Lualine
  'nvim-lualine/lualine.nvim',
  'kdheepak/tabline.nvim',

  -- Syntax
  'Yggdroot/indentline',
  'stephpy/vim-yaml',
  'hashivim/vim-terraform',

  -- Git
  'lewis6991/gitsigns.nvim',
  'tpope/vim-fugitive',

  -- Utilities
  'terrortylor/nvim-comment',
  'sjl/gundo.vim',
  'tpope/vim-surround',
  'jiangmiao/auto-pairs',
  -- 'folke/which-key.nvim',

  -- Language Server Protocol (LSP)
  -- use { 'williamboman/nvim-lsp-installer' }
  'neovim/nvim-lspconfig',

  -- Mason
  'williamboman/mason.nvim',
  'williamboman/mason-lspconfig.nvim',

  -- Rusty things
  'simrat39/rust-tools.nvim',

  -- Telescope
  'nvim-telescope/telescope.nvim',

  -- Treesitter
  'nvim-treesitter/nvim-treesitter',
  --     run = ':TSUpdate'
  'nvim-treesitter/playground',
  'nvim-treesitter/nvim-treesitter-textobjects',

  -- Completion
  'hrsh7th/nvim-cmp',
  'hrsh7th/cmp-nvim-lsp',                -- lsp completions
  'hrsh7th/cmp-nvim-lua',                -- lua completions
  'hrsh7th/cmp-nvim-lsp-signature-help', -- lsp signature completions
  'hrsh7th/cmp-vsnip',                   -- VSCode(LSP)'s snippet feature in vim/nvim
  'hrsh7th/cmp-path',                    -- path completions
  'hrsh7th/cmp-buffer',                  -- buffer completions
  -- 'hrsh7th/cmp-cmdline',  -- command line completions

  'onsails/lspkind-nvim', -- vscode-like pictograms

  -- snippets
  'hrsh7th/vim-vsnip',
  -- 'L3MON4D3/LuaSnip',             --snippet engine
  -- 'saadparwaiz1/cmp_luasnip',
  -- 'rafamadriz/friendly-snippets', -- a bunch of snippets to use
  --
  -- File system access
  'kyazdani42/nvim-tree.lua',

  -- neo-tree
  -- Unless you are still migrating, remove the deprecated commands from v1.x
  -- vim.cmd([[ let g:neo_tree_remove_legacy_commands = 1 ]])

  -- 'nvim-neo-tree/neo-tree.nvim',
  --     branch = "v2.x",
  --     requires = {
  --         "nvim-lua/plenary.nvim",
  --         "nvim-tree/nvim-web-devicons", -- not strictly required, but recommended
  --         "MunifTanjim/nui.nvim",

  -- netman.nvim - remote file system access
  -- 'miversen33/netman.nvim',

  -- terminal
  'akinsho/toggleterm.nvim',
  'voldikss/vim-floaterm',

  -- debugging
  'mfussenegger/nvim-dap',
  'leoluz/nvim-dap-go',
  'rcarriga/nvim-dap-ui',
  'theHamsta/nvim-dap-virtual-text',
  'nvim-telescope/telescope-dap.nvim',

  -- Symbols
  'simrat39/symbols-outline.nvim',

  -- Neorg
  -- https://github.com/nvim-neorg/neorg
  -- 'nvim-neorg/neorg',
  --     run = ":Neorg sync-parsers",
  --     requires = { "nvim-lua/plenary.nvim" }
}
