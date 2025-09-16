-- Define weasel words pattern
local weasel_pattern =
[[\v<(many|various|very|fairly|several|extremely|exceedingly|quite|remarkably|few|surprisingly|mostly|largely|huge|tiny|excellent|interestingly|significantly|substantially|clearly|vast|relatively|completely)>|<(are|is)\s+a\s+number>]]

-- Create highlight group for weasel words
vim.api.nvim_set_hl(0, 'WeaselWords', {
  fg = '#ff0000',
  bold = true,
  underline = true
})

-- Function to toggle weasel word highlighting
local function toggle_weasel_highlighting()
  -- Check if highlighting is already active
  local matches = vim.fn.getmatches()
  local weasel_match_exists = false

  for _, match in ipairs(matches) do
    if match.group == 'WeaselWords' then
      vim.fn.matchdelete(match.id)
      weasel_match_exists = true
      print("Weasel word highlighting disabled")
      break
    end
  end

  if not weasel_match_exists then
    vim.fn.matchadd('WeaselWords', weasel_pattern)
    print("Weasel word highlighting enabled")
  end
end

-- Create user command to toggle highlighting
vim.api.nvim_create_user_command('ToggleWeaselWords', toggle_weasel_highlighting, {})

-- Optional: Auto-enable for specific filetypes (markdown, text, etc.)
vim.api.nvim_create_autocmd('FileType', {
  pattern = { 'markdown', 'text', 'rst', 'asciidoc' },
  callback = function()
    vim.fn.matchadd('WeaselWords', weasel_pattern)
  end,
})

-- Optional: Create a keybinding for quick toggle
vim.keymap.set('n', '<leader>tw', toggle_weasel_highlighting, { desc = 'Toggle weasel word highlighting' })
