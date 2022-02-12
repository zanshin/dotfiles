-- Treesitter
local ts = require 'nvim-treesitter.configs'
ts.setup {
 ensure_installed = 'maintained',
 highlight = {
   enable = true,
 },
 playground = {
   enable = true,
   disable = {},
   updatetime = 25,           -- debounced time for highlighted nodes in playground from source code
   persist_queries = false,   -- whether the query persists across vim sessions
   keybindings = {
     toggle_query_editor = 'o',
     toggle_hl_groups = 'i',
     toggle_injected_languages = 't',
     toggle_anonymous_nodes = 'a',
     toggle_language_display = 'I',
     focus_language = 'f',
     unfocus_language = 'F',
     update = 'R',
     goto_node = '<cr>',
     show_help = '?',
   },
 }
}

