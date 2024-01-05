-- Rust tools
return {
  'simrat39/rust-tools.nvim',
  event = 'InsertEnter',
  opts = {
    server = {
      settings = {
        ["rust-analyzer"] = { cargo = { allFeatures = true } },
      },
      -- on_attach = function(_, bufnr)
      --   -- Hover actions
      --   vim.keymap.set("n", "<C-space>", hover_actions, { buffer = bufnr })
      --   -- Code action groups
      --   vim.keymap.set("n", "<Leader>a", code_action_group, { buffer = bufnr })
      -- end,
    },
    -- local opts = {
    tools = {
      inlay_hints = {
        auto = true,
        only_current_line = false,
        show_parameter_hints = true,
        parameter_hints_prefix = "<-",
        other_hints_prefix = "=>",
        max_length_align = false,
        max_length_align_padding = 1,
        right_align = false,
        right_align_padding = 7,
        highlight = "Comment",
        -- highlight = "Todo"
        -- highlight = "TabLine"
      },
    },
  }
}
