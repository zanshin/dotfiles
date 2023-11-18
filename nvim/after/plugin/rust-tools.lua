local status_ok, rt = pcall(require, "rust-tools")
if not status_ok then
  return
end

-- local opts = {
--   tools = {
--     inlay_hints = {
--       -- highlight = "Comment"
--       highlight = "Error"
--     },
--   },
-- }

rt.setup({
  server = {
    settings = {
      ["rust-analyzer"] = { cargo = { allFeatures = true } },
    },
    on_attach = function(_, bufnr)
      -- Hover actions
      vim.keymap.set("n", "<C-space>", rt.hover_actions.hover_actions, { buffer = bufnr })
      -- Code action groups
      vim.keymap.set("n", "<Leader>a", rt.code_action_group.code_action_group, { buffer = bufnr })
    end,
  },
  -- local opts = {
  tools = {
    inlay_hints = {
      -- highlight = "Comment"
      -- highlight = "Todo"
      highlight = "TabLine"
    },
  },
  -- },
})

-- Enable inlay hints auto update and set them for all the buffers
