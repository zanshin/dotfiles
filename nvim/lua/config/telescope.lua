-- Telescope
local actions = require("telescope.actions")
require("telescope").setup {
 defaults = {
--    file_sorter = require('telescope.sorters').get_fzy_sorter,

   file_previewer   = require('telescope.previewers').vim_buffer_cat.new,
   grep_previewer   = require('telescope.previewers').vim_buffer_vimgrep.new,
   qflist_previewer = require('telescope.previewers').vim_buffer_qflist.new,
   mappings = {
     i = {
       -- Also close on ESC in insert mode
       ["<esc>"] = actions.close,
       ["<C-[>"] = actions.close,
       ["<C-q>"] = actions.send_to_qflist,
     },
   },
 },
}

-- require('telescope').load_extension('fzy_native')

local map_options = { noremap = true, silent = true }

local map_builtin = function(key, f)
 local ths = string.format("<cmd>lua require('telescope.builtin')[%s']()<CR>", f)
 map("n", key, rhs, map_options)
end

-- Find files using Telescope command-line sugar.
map('n', '<leader>ff', '<cmd>Telescope find_files<cr>')
map('n', '<leader>fg', '<cmd>Telescope live_grep<cr>')

map('n', '<Leader>fb', ':Telescope buffers<CR>')
map('n', '<Leader>fo', ':Telescope commands<CR>')
map('n', '<Leader>fq', ':Telescope quick_fix<CR>')
map('n', '<Leader>fgs', ':Telescope git_status<CR>')
map('n', '<Leader>fgf', ':Telescope git_files<CR>')
map('n', '<Leader>fgc', ':Telescope git_commits<CR>')
map('n', '<Leader>fgb', ':Telescope git_branches<CR>')
map('n', '<Leader>fgt', ':Telescope git_stash<CR>')

-- nnoremap <leader>ff <cmd>Telescope find_files<cr>
-- nnoremap <leader>fg <cmd>Telescope live_grep<cr>
-- nnoremap <leader>fb <cmd>Telescope buffers<cr>
-- nnoremap <leader>fh <cmd>Telescope help_tags<cr>

-- Using Lua functions
-- nnoremap <leader>ff <cmd>lua require('telescope.builtin').find_files()<cr>
-- nnoremap <leader>fg <cmd>lua require('telescope.builtin').live_grep()<cr>
-- nnoremap <leader>fb <cmd>lua require('telescope.builtin').buffers()<cr>
-- nnoremap <leader>fh <cmd>lua require('telescope.builtin').help_tags()<cr>

