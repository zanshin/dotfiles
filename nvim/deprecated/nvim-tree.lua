-- neotree
return {
  "nvim-tree/nvim-tree.lua",
  version = "*",
  lazy = false,
  dependencies = {
    "nvim-tree/nvim-web-devicons",
    "antosha417/nvim-lsp-file-operations",
  },
  options = {
    disable_netrw = true,
    hijack_netrw = true,
    open_on_setup = false,
    ignore_ft_on_setup = {
      "startify",
      "dashboard",
      "alpha",
    },
    auto_close = true,
    open_on_tab = false,
    hijack_cursor = false,
    update_cwd = true,
    update_to_buf_dir = {
      enable = true,
      auto_open = true,
    },
    diagnostics = {
      enable = true,
      icons = {
        hint = "",
        info = "",
        warning = "",
        error = "",
      },
    },
    update_focused_file = {
      enable = true,
      update_cwd = true,
      ignore_list = {},
    },
    git = {
      enable = true,
      ignore = true,
      timeout = 500,
    },
    view = {
      width = 30,
      height = 30,
      hide_root_folder = false,
      side = "left",
      auto_resize = true,
      -- mappings = {
      --   custom_only = false,
      --   list = {
      --     { key = { "l", "<CR>", "o" }, cb = tree_cb "edit" },
      --     { key = "h",                  cb = tree_cb "close_node" },
      --     { key = "v",                  cb = tree_cb "vsplit" },
      --   },
      -- },
      number = false,
      relativenumber = false,
    },
    quit_on_open = 0,
    git_hl = 1,
    disable_window_picker = 0,
    root_folder_modifier = ":t",
    show_icons = {
      git = 1,
      folders = 1,
      files = 1,
      folder_arrows = 1,
      tree_width = 30,
    },
  },
  config = function()
    require("nvim-tree").setup {}
  end,
}
