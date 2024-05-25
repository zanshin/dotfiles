require("luasnip.session.snippet_collection").clear_snippets "lua"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_code

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("lua", {
  -- -- format snippet 
  -- s("snipf", fmt([[ 
  --     <>({ trig='<>', name='<>', dscr='<>'},
  --     fmt(<>,
  --     { <> },
  --     { delimiters='<>' }
  --     )<>)<>,]],
  --     { c(1, {t("s"), t("autosnippet")}), i(2, "trig"), i(3, "trig"), i(4, "dscr"), i(5, "fmt"), i(6, "inputs"), i(7, "<>"), i(8, "opts"), i(0)},
  --     { delimiters='<>' }
  --     )),

  -- simple text snippet 
  -- s("snipt", fmt([[ 
  --     <>(<>, {t('<>')}<>
  --     <>)<>,]],
  --     { c(1, {t("s"), t("autosnippet")}), c(2, {i(nil, "trig"), sn(nil, {t("{trig='"), i(1), t("'}")})}), i(3, "text"), i(4, "opts"), i(5), i(0)},
  --     { delimiters='<>' }
  --   )),
})
