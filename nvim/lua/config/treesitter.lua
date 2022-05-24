-- Treesitter
local status_ok, ts = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

ts.setup {
 ensure_installed = 'maintained',
 sync_install = false,
 ignore_install = { "" },    -- list of parses to ignore installing
 highlight = {
   enable = true,             -- false will disable entire extension
   disable = { "" },          -- list of languages that will be disabled
   additional_vim_reqex_highlighting = true,
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

  indent = { enable = true, disable = { "yaml"  } },
 },

 textobjects = {
   select = {
     enable = true,

     -- automatically jump forward to textobj
     lookahead = true,

     keymaps = {
       -- you can use capture groups defined in textobjects.cm
       ["af"] = "@function.outer",
       ["if"] = "@function.inner",
     },
   },
 },
}
