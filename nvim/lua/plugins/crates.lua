-- Crates
-- August 6, 2025
--

return {
  'saecki/crates.nvim',
  event = { "BufRead Cargo.toml" },
  dependencies = { 'nvim-lua/plenary.nvim' },
  config = function()
    require('crates').setup {
      smart_insert = true,
      autoload = true,
      autoupdate = true,
    }
  end,
}
