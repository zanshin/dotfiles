-- Indentation
vim.opt.autoindent = true  -- Yes, please
vim.opt.expandtab = true   -- Use spaces instead of tabs
vim.opt.shiftwidth = 2     -- Size of an indent
vim.opt.shiftround = true  -- Round indent
vim.opt.smartindent = true -- Insert indents automatically
vim.opt.softtabstop = 2
vim.opt.tabstop = 2        -- Number of spaces tabs count for

-- Buffers
vim.opt.hidden = true -- buffer switch without saving

-- Swap,backup, undo
vim.opt.swapfile = false -- no swap file
vim.opt.backup = false   -- no backup file either
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true  -- let's have an undo file, at the location above

-- Search
vim.opt.ignorecase = true -- Ignore case
vim.opt.smartcase = true  -- Set 'noignorecae' if search pattern contains an uppercase letter
vim.opt.gdefault = true   -- apply substitutions globbaly - use 'g' for old style
vim.opt.incsearch = true  -- use incremental search
vim.opt.hlsearch = true   -- highlight search results

-- UI
vim.opt.number = true         -- Show line numbers
vim.opt.relativenumber = true -- Relative line numbers
-- vim.opt.statuscolumn = '%=%{v:lnum} | %{v:relnum} '
vim.opt.numberwidth = 6       -- set number column width to 4. default is 2
vim.opt.signcolumn = "yes"    -- always show to prevent text shifting
vim.opt.ruler = true          -- show current cursor position
vim.opt.linebreak = true      -- wrap intelligently - no hard line breaks
vim.opt.linespace = 3         -- prefer a slightly higher line height
vim.opt.wrap = true           -- Disable line wrap
vim.opt.showmode = false      -- Disable native mode indicator
--vim.opt.showtabline = 2                    -- always show tabline
vim.opt.pumheight = 10        -- pop up menu height
-- Cool floating window popup menu for completion on command line
vim.opt.pumblend = 17
vim.opt.wildmode = "longest:full"
vim.opt.wildoptions = "pum"

vim.opt.list = true -- Show some invisible characters
vim.opt.listchars = { -- Strings to use when 'list' vim.opt.on set.
  tab = '│ ', -- Characters to be used to show a tab.
  nbsp = '␣', -- Character to show for a non-breakable space character.
  extends = '❯', -- Character to show in last column, when 'wrap' is off
  precedes = '❮', -- Character to show in first visible column
  eol = '¬', -- Character to show at end of line
  trail = '⋅', -- Character to show trailing spaces
}

vim.opt.ruler = true         -- show current cursor position
vim.opt.cursorline = true    -- highlight line where cursor is
vim.opt.showmatch = true     -- show matching brackets [{()}]
vim.opt.lazyredraw = true    -- Redraw only when necessary
vim.opt.termguicolors = true -- True color support
vim.opt.textwidth = 79       -- ... at column 79

vim.opt.inccommand = "split" -- incrementally show results of s/../../

-- UX
-- vim.opt.pastetoggle = "<F2>" -- toggle paste mode on/off
vim.opt.splitbelow = true  -- Put new windows below current
vim.opt.splitright = true  -- Put new windows right of current
vim.opt.joinspaces = false -- No double spaces with join

vim.opt.backspace = {      -- Make backspace behave in a sane manner
  'indent',
  'eol',
  'start'
}

-- Folding
-- Treesitter folding
-- vim.wo.foldmethod = 'expr'
-- vim.wo.foldexpr = 'nvim_treesitter#foldexpr()'

vim.opt.foldcolumn = "3"      -- Room for fold markers
vim.opt.foldenable = true     -- Enable folding
vim.opt.foldmethod = "marker" -- Standard 3 curly braces as markers

-- Format vim.opt.ons
vim.opt.formatoptions = vim.opt.formatoptions
    - "a" -- Auto formatting is BAD.
    - "t" -- Don't auto format my code. I got linters for that.
    + "c" -- In general, I like it when comments respect textwidth
    + "q" -- Allow formatting comments w/ gq
    - "o" -- O and o, don't continue comments
    -- + "r" -- But do continue when pressing enter.
    + "n" -- Indent past the formatlistpat, not underneath it.
    + "j" -- Auto-remove comments if possible.
    - "2" -- I'm not in gradeschool anymore


vim.opt.cpoptions = table.concat {
  '$', -- set $ at end of change range
}

vim.opt.showmatch = true -- show matching brackets [{()}]
-- vim.opt.matchpairs = '<:>' -- also match < and >
vim.opt.timeoutlen = 500 -- Time in milliseconds to wait for a mapped sequence to complete
vim.opt.ttimeoutlen = 50 -- Key code time out

-- Completions
--Set completevim.opt.to have a better completion experience
-- :help completeopt
-- menuone: popup even when there's only one match
-- noinsert: Do not insert text until a selection is made
-- noselect: Do not select, force to select one from the menu
-- shortness: avoid showing extra messages when using completion
-- updatetime: set updatetime for CursorHold
vim.opt.completeopt = { 'menuone', 'noselect', 'noinsert' }
vim.opt.shortmess:append"c"
vim.api.nvim_set_option('updatetime', 300)

-- Fixed column for diagnostics to appear
-- Show autodiagnostic popup on cursor hover_range
-- Goto previous / next diagnostic warning / error
-- Show inlay_hints more frequently
vim.cmd([[
set signcolumn=yes
autocmd CursorHold * lua vim.diagnostic.open_float(nil, { focusable = false })
]])

-- Diagnostics - reduce updatetime for CursorHold
vim.opt.updatetime = 250

-- Messages
vim.opt.shortmess:append {
  I = true, -- No splash screen
  --  W = true,                            -- Don't print "written" when editing
  a = true, -- Use abbreviations in messages ([RO] intead of [readonly])
  c = true, -- Do not show ins-completion-menu messages (match 1 of 2)
}

-- Navigation
vim.opt.scrolloff = 5      -- Lines of context
vim.opt.sidescrolloff = 10 -- Columns of context
vim.opt.sidescroll = 1     -- number of columns to scroll at a time

-- Status
vim.opt.laststatus = 2 -- always show the status line
vim.opt.showcmd = true -- show the command
vim.opt.cmdheight = 2  -- make status two-lines tall

-- File focus
vim.opt.autowrite = true -- write out old file when switching between files
vim.opt.autoread = true  -- reload files changed on disk

-- Spelling
-- vim.opt.spellfile = "~/.config/nvim/spell/en.uft-8.add"
vim.opt.encoding = "utf-8"
vim.opt.spelllang = "en"

-- Encoding - we like UTF-8
-- vim.opt.fileencoding = "utf-8"
--
-- vim.opt.termencoding = "utf-8"
-- vim.opt.encoding=utf-8
-- vim.opt.noshowmode                   -- don't show the mode - lightline will do that
