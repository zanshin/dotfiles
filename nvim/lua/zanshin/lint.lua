function Cfnlint()
  -- save current buffer
  vim.cmd("write")

  -- define the lint command
  local command = "Cfn-lint " .. vim.fn.expand("%")

  -- run the command and collect the output
  local output = vim.fn.systemlist(command)

  -- create a list of quickfix entires
  local quickfix_list = {}
  for _, line in ipairs(output) do
    table.insert(quickfix_list, {
      filename = vim.fn.expand("%"),
      lnum = tonumber(string.match(line, "^d+")) or 1,
      text = line,
    })
  end

  -- set the quickfix list and open it
  vim.fn.setqflist({}, " ", {
    title = "cfn-lint",
    items = quickfix_list,
  })
  vim.cmd("copen")
end

-- define the new command
vim.api.nvim_create_user_command("RunExternal", Cfnlint, {})

-- map <leader>cf to run the linter
vim.api.nvim_set_keymap(
  "n",
  "<leader>cf",
  ":lua Cfnlint()<CR>",
  { noremap = true, silent = true }
)
