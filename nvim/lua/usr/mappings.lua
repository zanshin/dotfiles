-- Mappings
--
-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"

map("", "<Space>", "<Nop>")                   -- map Space to a no-op
g.mapleader = ' '                             -- space for leader
g.maplocalleader = ' '                        -- space for local leader too
map('n', ';', ':')                            -- use ; for : in normal mode
map('n', ';;', ';')                           -- use ;; for ; in normal mode

-- Disable arrow keys and make semi-snarky comment instead
map('n', '<Left>',  ':echo "Use h"<CR>')
map('n', '<Right>', ':echo "Use l"<CR>')
map('n', '<Up>',    ':echo "Use k"<CR>')
map('n', '<Down>',  ':echo "Use j"<CR>')

-- Use Control-hjkl to switch between splits
map('n', '<C-h>', '<C-w>h')
map('n', '<C-j>', '<C-w>j')
map('n', '<C-k>', '<C-w>k')
map('n', '<C-l>', '<C-w>l')

-- Move to first non-blank or last non-blank character in current line
map('n', 'H', '^')
map('n', 'L', 'g_')

-- Fix regex handling to be "normal"
-- map('n', '/', '/\v')
-- map('v', '/', '/\v')

-- Map escape to jj -- faster to typ
--Also, jk and kj. The more the merrier
map('i', 'jj', '<ESC>')
map('i', 'jk', '<ESC>')
map('i', 'kj', '<ESC>')

-- Remove search highlighting with <leader>/
map('n', '<leader>/', ':nohlsearch<CR>')
-- nnoremap <silent> <leader>/ :nohlsearch<CR>
--
-- -- Relative number / absolue numbr toggle
map('n', '<F10>', ':set relativenumber! number! number?<CR>')

-- Move line(s) up or down via Control-j and Control-k respectively
-- not sure why all of these aren't working
-- map('n', '<M-j>', ':m .+1<CR>==')
-- map('n', '<M-k>', ':m .-2<CR>==')
-- map('i', '<M-j>', ':m <ESC>:m .+1<CR>==gi')
-- map('i', '<M-k>', ':m <ESC>:m .-2<CR>==gi')
-- map('v', '<M-j>', ':m \'>+1<CR>gv=gv')
-- map('v', '<M-k>', ':m \'>-2<CR>gv=gv')

-- Buffers and tabs
map('n', '<leader>be', ':enew<CR>')           -- create new empty buffer
map('n', '<leader>bn', ':bnext<CR>')          -- move to next buffer
map('n', '<leader>bp', ':bprevious<CR>')      -- move to previous buffer
map('n', '<leader>bc', ':bp <BAR> bd $<CR>')  -- move to previous buffer, and close current

map('n', '<S-n>', ':bnext<CR>')               -- move to next buffer
map('n', '<S-p>', ':bprevious<CR>')           -- move to previous buffer

-- Neovim configuration file
map('n', '<leader>ev', '<cmd>e $MYVIMRC<CR>') -- open configuration file for editing
-- map('n', '<leader>sv', ':luafile %<CR>')      -- source nvim configuration
map('n', '<silent><leader>sv', ':source ~/.config/nvim/init.lua<CR>:filetype detect<CR>')

-- Treesitter mappings
map('n', '<leader>tsp', ':TSPlaygroundToggle<CR>')
map('n', '<leader>tsh', ':TSHighlightCapturesUnderCursor<CR>')

-- Telescope mappings
map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fgg', ':Telescope live_grep<CR>')
map('n', '<Leader>fb', ':Telescope buffers<CR>')
map('n', '<Leader>fo', ':Telescope commands<CR>')
map('n', '<Leader>fq', ':Telescope quick_fix<CR>')
map('n', '<Leader>fgs', ':Telescope git_status<CR>')
map('n', '<Leader>fgf', ':Telescope git_files<CR>')
map('n', '<Leader>fgc', ':Telescope git_commits<CR>')
map('n', '<Leader>fgb', ':Telescope git_branches<CR>')
map('n', '<Leader>fgt', ':Telescope git_stash<CR>')

-- map('n', '<Leader>s', 'require("telescope.builtin").spell_suggest(require("telescope.themes").get_cursor({}))')


-- Sudo to write protected file
map('c', 'w!!', '!sudo tee % >/dev/null')

-- Toggle listchars on / off
map('n', '<leader>l', ':set list!<cr>')

-- Splits
map('n', '<leader>v', '<C-w>v<C-w>l')         -- open a vertical split and switch to it
map('n', '<leader>h', '<C-w>s<C-w>j')         -- open a horizontal split and switch to it

-- System clipboard
map('n', '<leader>y', '+y')

-- nvim-tree
map('n', '<C-n>', ':NvimTreeToggle<cr>')
map('n', '<leader>r', ':NvimTreeRefresh')

