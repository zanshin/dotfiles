-- My Options
-- August 4, 2024
--

-- Add line numbers and relative line numbers
vim.o.number = true
vim.o.relativenumber = true

-- Always show a wider sign column
vim.o.signcolumn = 'yes'
vim.o.numberwidth = 6

-- Control indentation
vim.o.autoindent = true  -- Yes, please
vim.o.expandtab = true   -- Use spaces instead of tabs
vim.o.shiftwidth = 2     -- Size of an indent
vim.o.shiftround = true  -- Round indent
vim.o.smartindent = true -- Insert indents automatically
vim.o.softtabstop = 2
vim.o.tabstop = 2        -- Number of spaces tabs count for

-- Open splits to right or bottom
vim.o.splitright = true
vim.o.splitbelow = true

-- Cursor line and ruler
vim.o.ruler = true
vim.o.cursorline = true

-- Decrease update and mapped sequence wait times
vim.o.updatetime = 250
vim.o.timeoutlen = 300

-- Minimum number of lines to keep on screen above/below cursor
vim.o.scrolloff = 10

-- Case insensitive search
vim.o.ignorecase = true
vim.o.smartcase = true

-- Apply substitutions globally
vim.o.gdefault = true

-- Preview substitutions live
vim.o.inccommand = 'split'

-- Statusline
vim.o.cmdheight = 2
vim.o.showcmd = false

-- Encoding and Language
vim.o.encoding = 'utf-8'
vim.o.spelllang = 'en'
vim.o.spellfile = vim.fn.expand("~/.config/nvim/spell/en.utf-8.add")

-- Folding
vim.o.foldcolumn = '3'
vim.o.foldenable = true
vim.o.foldmethod = 'marker'

-- Swap, backup, and undo
vim.o.swapfile = false
vim.o.backup = false
vim.o.undodir = os.getenv('HOME') .. '/.local/share/nvim/undodir'
vim.o.undofile = true

-- Line width 
vim.o.textwidth = 79
vim.o.linebreak = true
