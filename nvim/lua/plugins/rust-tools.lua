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
        -- highlight = "Comment"
        -- highlight = "Todo"
        highlight = "TabLine"
      },
    },
  }
}
