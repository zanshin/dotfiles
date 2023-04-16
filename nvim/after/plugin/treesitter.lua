-- Treesitter
local status_ok, ts = pcall(require, "nvim-treesitter.configs")
if not status_ok then
  return
end

ts.setup {
  -- ensure_installed = "maintained",
  ensure_installed = {
    "bash",
    "css",
    "go",
    "help",
    "html",
    "javascript",
    "json",
    "lua",
    "markdown",
    "python",
    "rust",
    "toml",
    "typescript",
    "vim",
    "vimdoc"
  },
  sync_install = false,
  ignore_install = { "" }, -- list of parses to ignore installing
  highlight = {
    enable = true,         -- false will disable entire extension
    disable = { "" },      -- list of languages that will be disabled
    additional_vim_reqex_highlighting = true,
  },

  autopairs = {
    enable = true,
  },

  rainbow = {
    enable = true,
    colors = {
      "Gold",
      "Orchid",
      "DodgerBlue",
      "Cornsilk",
      "Salmon",
      "LawnGreen",
    },
    disable = { "html" },
  },

  playground = {
    enable = true,
    disable = {},
    updatetime = 25,         -- debounced time for highlighted nodes in playground from source code
    persist_queries = false, -- whether the query persists across vim sessions
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
    indent = { enable = true, disable = { "yaml" } },
  },

  textobjects = {
    select = {
      enable = true,
      -- automatically jump forward to textobj
      lookahead = true,
      keymaps = {
        -- you can use capture groups defined in textobjects.cm
        ['aa'] = '@parameter.outer',
        ['ia'] = '@parameter.inner',
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = 'class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
    swap = {
      enable = true,
      swap_next = {
        ['<leader>a'] = '@parameter.inner',
      },
      swap_previous = {
        ['<leader>A'] = '@parameter.inner',
      },
    },
  },
}
