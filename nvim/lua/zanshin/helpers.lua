-- Helpers
cmd = vim.cmd    -- to execute Vim commands. E.g., cmd('pwd')
fn = vim.fn      -- to call Vim functions. E.g., fn.bunnr()
g = vim.g        -- a table to access global variables
opt = vim.opt    -- to set options
api = vim.api    -- for api calls

execute = vim.api.nvim_command

-- Create mappings with noremap option set to true
function map(mode, lhs, rhs, opts)
 local options = {noremap = true, silent = true}
 if opts then options = vim.tbl_extend('force', options, opts) end
 vim.api.nvim_set_keymap(mode, lhs, rhs, options)
end
