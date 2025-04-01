return {
  "epwalsh/obsidian.nvim",
  version = "*",  -- recommended, use latest release instead of latest commit
  lazy = true,
  ft = "markdown",
  -- Replace the above line with this if you only want to load obsidian.nvim for markdown files in your vault:
  -- event = {
  --   -- If you want to use the home shortcut '~' here you need to call 'vim.fn.expand'.
  --   -- E.g. "BufReadPre " .. vim.fn.expand "~" .. "/my-vault/*.md"
  --   -- refer to `:h file-pattern` for more examples
  --   "BufReadPre path/to/my-vault/*.md",
  --   "BufNewFile path/to/my-vault/*.md",
  -- },
  -- event = {
  --   "BufReadPre " .. vim.fn.expand "~" .. "/Mobile Documents/com~apple~CloudDocs/Files/documents/vault/*.md",
  --   "BufNewFile " .. vim.fn.expand "~" .. "/Mobile Documents/com~apple~CloudDocs/Files/documents/vault/*.md",
  -- },
  dependencies = {
    "nvim-lua/plenary.nvim",
  },
  opts = {
    workspaces = {
      {
        name = "personal",
        -- path = "~/Mobile Documents/com~apple~CloudDocs/Files/documents/vault",
        path = "~/Documents/obsidian/personal",
      },
    },
  },
}
