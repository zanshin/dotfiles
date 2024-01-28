-- Mappings
-- Create mappings with noremap option set to true
local function map(mode, lhs, rhs, opts)
  local options = { noremap = true, silent = true }
  if opts then options = vim.tbl_extend('force', options, opts) end
  vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end

local g = vim.g -- a table to access global variables

-- Modes
--   normal_mode = "n"
--   insert_mode = "i"
--   visual_mode = "v"
--   visual_block_mode = "x"
--   term_mode = "t"
--   command_mode = "c"

map("", "<Space>", "<Nop>") -- map Space to a no-op
g.mapleader = ' '           -- space for leader
g.maplocalleader = ' '      -- space for local leader too
map('n', ';', ':')          -- use ; for : in normal mode
map('n', ';;', ';')         -- use ;; for ; in normal mode

-- Disable arrow keys and make semi-snarky comment instead
map('n', '<Left>', ':echo "Use h"<CR>')
map('n', '<Right>', ':echo "Use l"<CR>')
map('n', '<Up>', ':echo "Use k"<CR>')
map('n', '<Down>', ':echo "Use j"<CR>')

-- Use Control-hjkl to switch between splits
map('n', '<S-h>', '<C-w>h')
map('n', '<S-j>', '<C-w>j')
map('n', '<S-k>', '<C-w>k')
map('n', '<S-l>', '<C-w>l')

-- Move to first non-blank or last non-blank character in current line
map('n', 'F', '^')
map('n', 'L', 'g_')

-- Fix regex handling to be "normal"
-- map('n', '/', '/\v')
-- map('v', '/', '/\v')

-- Map escape to jj -- faster to type
--Also, jk and kj. The more the merrier
map('i', 'jj', '<ESC>')
map('i', 'jk', '<ESC>')
map('i', 'kj', '<ESC>')

-- Remove search highlighting with <leader>/
map('n', '<leader>/', ':nohlsearch<CR>')

-- Relative number / absolue numbr toggle
map('n', '<F10>', ':set relativenumber! number! number?<CR>')
map('n', 'nn', ':set norelativenumber<cr>')
map('n', 'rr', ':set relativenumber<cr>')

-- Move line(s) up or down via J and K respectively
-- map('v', '<C-j>', ":m '>+1<CR>gv=gv")
-- map('v', '<C-k>', ":m '<-2<CR>gv=gv")
-- Normal mode
-- map('n', '<C-D>', ':m .+1<cr>==')
-- map('n', '<C-U>', ':m .-2<cr>==')

-- Insert mode
-- map('i', '<C-d>', '<ESV>:m .+1<cr>==gi')
-- map('i', '<C-u>', '<ESV>:m .-2<cr>==gi')

-- Visual mode
-- map('v', '<C-d>', ':m >+1<cr>gv=gv')
-- map('v', '<C-u>', ':m >-2<cr>gv=gv')

-- Scroll 1/2 a page and center
map("n", "<C-d>", "<C-d>zz")
map("n", "<C-u>", "<C-u>zz")

-- Override n/N to show next/previous search result, but centered
map("n", "n", "nzzzv")
map("n", "N", "Nzzzv")

-- Buffers and tabs
map('n', '<leader>be', ':enew<CR>')          -- create new empty buffer
map('n', '<leader>bn', ':bnext<CR>')         -- move to next buffer
map('n', '<leader>bp', ':bprevious<CR>')     -- move to previous buffer
map('n', '<leader>bc', ':bp <BAR> bd $<CR>') -- move to previous buffer, and close current

map('n', '<S-n>', ':bnext<CR>')              -- move to next buffer
map('n', '<S-p>', ':bprevious<CR>')          -- move to previous buffer

-- Sudo to write protected file
map('c', 'w!!', '!sudo tee % >/dev/null')

-- Toggle listchars on / off
map('n', '<leader>l', ':set list!<cr>')

-- Splits
map('n', '<leader>v', '<C-w>v<C-w>l') -- open a vertical split and switch to it
map('n', '<leader>h', '<C-w>s<C-w>j') -- open a horizontal split and switch to it

-- System clipboard
map('n', '<leader>y', '"+y')
map('n', '<leader>p', '"+p')
map('n', '<leader>d', '"+d')

-- Use jq to format JSON
map('n', '<leader>jq', ':%!jq .<cr>')

-- Neovim configuration file
map('n', '<leader>ev', '<cmd>e $MYVIMRC<CR>') -- open configuration file for editing
-- map('n', '<leader>sv', ':luafile %<CR>')      -- source nvim configuration
map('n', '<silent><leader>sv', ':source ~/.config/nvim/init.lua<CR>:filetype detect<CR>')

-- Quickfix
map('n', '<leader>qn', ':cnext<cr>') -- jump to next quickfix list item
map('n', '<leader>qp', ':cprev<cr>') -- jump to prev quickfix list item

-- -----------------------------------------------------------------------
-- Plugin mappings
-- -----------------------------------------------------------------------
-- Treesitter mappings
map('n', '<leader>tsp', ':TSPlaygroundToggle<CR>')
map('n', '<leader>tsh', ':TSHighlightCapturesUnderCursor<CR>')
map('n', '<leader>U', ':Telescope undo<cr>')

-- Telescope mappings
map('n', '<leader>ff', ':Telescope find_files<CR>')
map('n', '<leader>fh', ':Telescope help_tags<CR>')
map('n', '<leader>fw', ':Telescope live_grep<CR>')
map('n', '<Leader>fb', ':Telescope buffers<CR>')
map('n', '<Leader>fo', ':Telescope commands<CR>')
map('n', '<Leader>fgs', ':Telescope git_status<CR>')
map('n', '<Leader>fgf', ':Telescope git_files<CR>')
map('n', '<Leader>fgc', ':Telescope git_commits<CR>')
map('n', '<Leader>fgb', ':Telescope git_branches<CR>')
map('n', '<Leader>fgt', ':Telescope git_stash<CR>')

-- Neo-tree
map('n', '\\', ':Neotree reveal<cr>')
map('n', '<C-n>', ':Neotree toggle<cr>')

-- nvim-tree
-- map('n', '<C-n>', ':NvimTreeToggle<cr>')
-- map('n', '<leader>r', ':NvimTreeRefresh')

-- DAP mappings -- moved to plugin configs
map("n", "<leader>dt", ":lua require'dapui'.DapUiToggle<cr>")
map("n", "<leader>dc", ":lua require'dap'.continue()<cr>")
map("n", "<leader>dsi", ":lua require'dap'.step_into()<cr>")
map("n", "<leader>dso", ":lua require'dap'.step_over()<cr>")
map("n", "<leader>dsu", ":lua require'dap'.step_out()<cr>")
map("n", "<leader>db", ":lua require'dap'.toggle_breakpoint()<cr>")
-- map("n", "<leader>dr", ":lua require'dap'.repl.open()<cr>")
map("n", "<leader>dr", ":lua require'dapui'.open({reset = true})<cr>")

-- Git Blame
map("n", "<leader>gb", ":GitBlameToggle<cr>")
