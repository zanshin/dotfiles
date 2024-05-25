require("luasnip.session.snippet_collection").clear_snippets "sh"

local ls = require "luasnip"

local s = ls.snippet
local i = ls.insert_node
local t = ls.text_node

local fmt = require("luasnip.extras.fmt").fmt

ls.add_snippets("sh", {
  s("#!", fmt("#! /usr/bin/env bash{}", { i(0) })),

  s("s#!", {
    t("#! /usr/bin/env bash"), t({"", "set -eu"}), i(0)
  }),

  s("if", {
    t("if [[ "), i(1), t(" ]]; then"), t({"", "  "}), i(2), t({"", "fi", ""}), i(3)
  })
})
