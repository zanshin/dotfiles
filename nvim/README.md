# Neovim Configuration

## Prerequisites

* Neovim 0.12.* or later
* Node - Several language servers require Node
* A "hacked" font

### Intel One Nerd Font
For MacOS:

* brew install font-intel-one-mono

## Organization

```bash
.
├── after
│   └── ftplugin
│       ├── go.lua
│       ├── help.lua
│       ├── mail.lua
│       ├── make.lua
│       ├── markdown.lua
│       ├── python.lua
│       ├── rust.lua
│       └── yaml.lua
├── init.lua
├── lazy-lock.json
├── lua
│   ├── my
│   │   ├── autocmds.lua
│   │   ├── mappings.lua
│   │   └── options.lua
│   └── plugins
│       ├── blink.lua
│       ├── colorscheme.lua
│       ├── crates.lua
│       ├── gitsigns.lua
│       ├── hardtime.lua
│       ├── lspconfig.lua
│       ├── notify.lua
│       ├── render-markdown.lua
│       ├── statusline.lua
│       ├── telescope.lua
│       ├── toggleterm.lua
│       ├── treesitter.lua
│       └── whichkey.lua
├── README.md
└── spell
    ├── en.utf-8.add
    └── en.utf-8.add.spl
```

### Directory Structure
The root of my Neovim configuration is the `init.lua`. This file sets up the lazy.nvim package
manager, and it loads my autocmds, options, and key mappings.

The `lua/plugins` directory holds the configuration for each plugin.
The `lua/my` directory is a namespace to hold my mappings, autocmds, and options. They are namespaced to prevent collisions with settings elsewhere in the configuration.
The `after/ftplugin` directory holds file type specific settings.

## Troubleshooting
If plugins stop loading properly, or develop odd problems, it may help to clean up these directories, which will trigger Lazy to reload all the plugins.

    rm -rf ~/.local/share/nvim ~/.cache/nvim ~/.local/site/nvim

