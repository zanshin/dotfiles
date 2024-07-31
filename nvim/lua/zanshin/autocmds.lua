-- formatoptions function
local function set_formatoptions()
  -- store the current 'formatoptions'
  local fo = vim.opt.formatoptions:get()
  -- remove 'a', 'o', 'r', 't', and '2'
  fo = fo:gsub("[aort2]", "")
  -- add 'c', 'q', 'n', and 'j'
  fo = fo .. "cqn"
  if not fo:find("j") then
    fo = fo .. "j"
  end
  -- set the modified 'formatoptions'
  vim.opt.formatoptions = fo
end

-- General autocmd group
local general_group = vim.api.nvim_create_augroup("General", { clear = true })

-- Set formatoptions on BufEnter
vim.api.nvim_create_autocmd("BufEnter", {
  callback = set_formatoptions,
  group = general_group,
})

-- Auto write all files and disable mouse on FocusLost, enable mouse on FocusGained
vim.api.nvim_create_autocmd({ "FocusLost", "FocusGained" }, {
  pattern = "*",
  group = general_group,
  callback = function(params)
    if params.event == "FocusLost" then
      vim.cmd(":wa")
      vim.opt.mouse = ""
    else
      vim.opt.mouse = "a"
    end
  end,
})

-- Format before saving
vim.api.nvim_create_autocmd("BufWritePre", {
  pattern = "*",
  callback = function()
    vim.lsp.buf.format()
  end,
  group = general_group,
})

-- Ensure modifiable buffers and diagnostics display on CursorHold
vim.api.nvim_create_autocmd({ "BufWinEnter", "CursorHold", "CursorHoldI" }, {
  pattern = "*",
  group = general_group,
  callback = function(params)
    if params.event == "BufWinEnter" then
      vim.opt.modifiable = true
    else
      vim.diagnostic.open_float(nil, { focus = false, scope = "cursor" })
    end
  end,
})

-- Specific filetype settings
vim.api.nvim_create_autocmd({ "BufNewFile", "BufRead" }, {
  pattern = "*.rss,*.atom",
  command = "setfiletype xml",
  group = general_group,
})

vim.api.nvim_create_autocmd("BufRead", {
  pattern = "COMMIT_EDITMSG",
  group = general_group,
  callback = function()
    vim.opt_local.spell = true
    vim.opt_local.spelllang = "en_us"
    vim.api.nvim_feedkeys("ggi", "t", true)
  end,
})

-- Whitespace trimming
vim.api.nvim_create_autocmd({ "FileWritePre", "FileAppendPre", "FilterWritePre", "BufWritePre" }, {
  pattern = "*",
  group = general_group,
  command = ":call TrimWhitespace()",
})

-- Define TrimWhitespace function
vim.api.nvim_exec([[
  function! TrimWhitespace()
    if &ft != 'mail'
      %s/\s\+$//e
    endif
  endfunction
]], false)

-- Highlight yank
vim.api.nvim_create_autocmd("TextYankPost", {
  group = vim.api.nvim_create_augroup("highlight_yank", { clear = true }),
  callback = function()
    vim.highlight.on_yank()
  end,
})

