## dotfiles

My configuration files, kept in one repository so I can set up any machine the
same way with one clone and one script.

macOS is my primary platform, and some of these configurations are tuned for
it. The Bash files also work on Linux. Linux-only configurations live in the
separate [neuepunkte](https://github.com/zanshin/neuepunkte) repository.

## Install

```sh
git clone https://github.com/zanshin/dotfiles.git ~/.dotfiles
cd ~/.dotfiles && ./install.sh
```

`install.sh` first pulls the latest `master` (skipped when no branch is checked
out, as in a Jujutsu-managed clone), then asks about each tool before linking
it. Each question has a default (shown as `Y/n` or `y/N`), so pressing Enter
through all of them gives my usual setup. It creates symlinks only; it
doesn't install any software.

`setup.sh` does the same job and adds a dry run (`./setup.sh -n`), automatic
backups of real files it would replace, and `-y` to accept every default.

Both scripts link Bash, Starship, Git, Jujutsu, Neovim, tmux, Alacritty, SSH,
and RubyGems. Everything else is linked by hand. [DETAILS.md](DETAILS.md) has
the commands for each tool.

## What's here

| Directory                       | What it configures                                                     |
| ------------------------------- | ---------------------------------------------------------------------- |
| `bash`                          | Bash: startup files plus `bash.d/` (PATH, exports, aliases, functions) |
| `starship`                      | [Starship](https://starship.rs) prompt, with Jujutsu status            |
| `nvim`                          | Neovim (lazy.nvim, LSP, Treesitter, Telescope, …)                      |
| `nvim-cheatsheet`               | A personal Neovim help page (`:help myhelp`)                           |
| `zed`                           | Zed editor settings, keymap, and tasks                                 |
| `git`                           | Git config, global ignores, attributes, SSH signing                    |
| `jj`                            | [Jujutsu](https://docs.jj-vcs.dev/latest/) config and aliases          |
| `ghostty`                       | Ghostty, my current terminal                                           |
| `tmux`                          | tmux                                                                   |
| `wezterm`, `kitty`, `alacritty` | Other terminals, rarely used                                           |
| `ayu`                           | Ayu Dark theme for Blink, an iOS terminal                              |
| `mutt`                          | Mutt/NeoMutt mail, with mbsync and msmtp (see [MUTT.md](MUTT.md))      |
| `ssh`                           | SSH client config                                                      |
| `gnupg`                         | GnuPG settings                                                         |
| `gem`                           | RubyGems settings                                                      |
| `brew`                          | Homebrew `Brewfile`s                                                   |
| `fonts`                         | Old font files                                                         |

[DETAILS.md](DETAILS.md) covers each one: what it does, where it's linked, and
anything to watch out for.
Neovim Configuration

## Prerequisites

- Neovim 0.12.* or later
- Node - Several language servers require Node
- A "hacked" font

### Intel One Nerd Font

For MacOS:

- brew install font-intel-one-mono

## Organization

```text
.
├── after
│   └── ftplugin
│       ├── go.lua
│       ├── help.lua
│       ├── mail.lua
│       ├── make.lua
│       ├── markdown.lua
│       ├── python.lua
│       ├── rust.lua
│       └── yaml.lua
├── init.lua
├── lua
│   ├── my
│   │   ├── autocmds.lua
│   │   ├── mappings.lua
│   │   ├── options.lua
│   │   └── weasel.lua
│   └── plugins
│       ├── autopairs.lua
│       ├── blink.lua
│       ├── claudecode.lua
│       ├── colorscheme.lua
│       ├── crates.lua
│       ├── dap.lua
│       ├── gen.lua
│       ├── gitsigns.lua
│       ├── hardtime.lua
│       ├── lspconfig.lua
│       ├── mason.lua
│       ├── render-markdown.lua
│       ├── rustacean.lua
│       ├── statusline.lua
│       ├── telescope.lua
│       ├── toggleterm.lua
│       ├── treesitter.lua
│       └── whichkey.lua
├── paused
│   └── notify.lua
├── README.md
└── spell
    └── en.utf-8.add
```

### Directory Structure

The root of my Neovim configuration is the `init.lua`. This file sets up the lazy.nvim package
manager, and it loads my options, key mappings, autocmds, and weasel-word highlighting.

- The `lua/plugins` directory holds the configuration for each plugin, one per file.
- The `lua/my` directory is a namespace to hold my mappings, autocmds, options, and weasel-word highlighting.
- The `paused` directory holds plugin specs I've set aside. Lazy doesn't load them.

They are namespaced to prevent collisions with settings elsewhere in the configuration.

The `after/ftplugin` directory holds file type specific settings.

## Weasel Words

Using the list of words from [3 shell scripts to improve your
writing](https://matt.might.net/articles/shell-scripts-for-passive-voice-weasel-words-duplicates/)
and with Claude.ai help, I added weasel word highlighting to my configuration.

## Troubleshooting

If plugins stop loading properly, or develop odd problems, it may help to clean up these directories, which will trigger Lazy to reload all the plugins.

    rm -rf ~/.local/share/nvim ~/.cache/nvim ~/.local/site/nvim
