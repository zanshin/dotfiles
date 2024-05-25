require("luasnip.session.snippet_collection").clear_snippets "lua"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("lua", {
-- vim.keymap.set with placeholders for mode, left hand side, rigth hand side
-- and description. The trailing placeholder is for ease of use.
  s("map", fmt("vim.keymap.set('{}', '{}', {{ desc = '{}' }}){}", { i(1), i(2), i(3), i(0) })),

})
