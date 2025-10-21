return {
  'mrcjkb/rustaceanvim',
  version = '^6',  -- Recommended
  lazy = false,    -- This plugin is already lazy
  ft = { "rust" }, -- Optional: only load for Rust files
  -- The vim.g.rustaceanvim configuration should be set in the init function,
  -- not config, because it needs to be available before the plugin loads.
  init = function()
    vim.g.rustaceanvim = {
      server = {
        settings = {
          ["rust-analyzer"] = {
            assist = {
              importGranularity = "module",
              importPrefix = "self",
              group = "crate",
            },
            completion = { autoimport = { enable = true } },
            procMacro = { enable = true },
            cargo = { allFeatures = true },
            check = {
              command = "clippy",
              extraArgs = { "--no-deps" },
            },
          },
        },
      },
    }
  end,
}
