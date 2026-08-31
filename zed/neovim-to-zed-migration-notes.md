# Neovim → Zed migration notes

Two files to drop in alongside your existing config:
- `settings.json` → `~/.config/zed/settings.json`
- `keymap.json` → `~/.config/zed/keymap.json`

Both **start from your current Zed config** and layer on the closest
equivalents to your Neovim setup. Comments in `settings.json` explain each
addition (Zed's settings parser accepts `//` comments; its keymap parser does
not, so the reasoning for `keymap.json` lives here instead).

## Direct, solid equivalents

| Neovim | Zed |
|---|---|
| `relativenumber` + `number` | `"relative_line_numbers": "enabled"` (already in your config) |
| `cursorline` | `"current_line_highlight": "all"` |
| `scrolloff = 10` | `"vertical_scroll_margin": 10` |
| `textwidth = 79` | `"preferred_line_length": 79` |
| `gdefault` | `"vim": { "gdefault": true }` |
| `smartcase` | `"vim": { "use_smartcase_find": true }` (already in your config) |
| system-clipboard yank/paste/delete leader maps | `"vim": { "use_system_clipboard": "always" }` (already in your config) — this makes plain `y`/`d`/`p` always hit the system clipboard, so the `<leader>y/p/d` maps become redundant and aren't ported |
| per-filetype `tabstop`/`shiftwidth`/`expandtab` (go, make, python, rust, yaml, markdown) | `"languages": { ... }` block — filled in Python and Rust, which your Zed config was missing; fixed `Make` (was missing `tab_size: 8`) |
| `vim.diagnostic.config({ virtual_text = false })` | `"diagnostics": { "inline": { "enabled": false } }` |
| LSP inlay hints + `<leader>th` toggle | `"inlay_hints": { "enabled": true, ... }` + `space t h` → `editor::ToggleInlayHints` |
| format-on-save via LSP | `"format_on_save": "on"`, `"formatter": "auto"` globally |
| `rust-analyzer` / `gopls` / `yaml-language-server` settings | ported as-is into `"lsp"` — Zed uses the same `initialization_options` shape you already had |
| gitsigns `current_line_blame` + `<leader>gb` toggle | Zed's native inline blame: `"git": { "inline_blame": { "enabled": true, "delay_ms": 1000 } }` + `space g b` → `editor::ToggleGitBlameInline` |
| `<leader>rn` (toggle relative numbers) | `space r n` → `editor::ToggleRelativeLineNumbers` |
| `g]`, `g[`, `gR`, `K`, `ga`, `gr`, `gcc` | unchanged — already in your keymap and correct |
| ayu-dark colorscheme, Intel One Mono / Hack Nerd Font | already in your settings, matches your nvim setup |
| autopairs, surround (`ys`/`cs`/`ds`), comment toggling (`gcc`) | built into Zed's vim mode natively, no config needed |
| treesitter-based folding, `foldenable = false` | Zed folds via tree-sitter out of the box and doesn't auto-close folds, matching your setup already |
| nvim-dap | Zed's built-in debugger: `f5`→`debugger::Start`, `f1`→`StepInto`, `f2`→`StepOver`, `f3`→`StepOut`, `space b`→`editor::ToggleBreakpoint`, `f7`→ opens the debug panel. You'll define launch configs in a project's `.zed/debug.json` instead of `dap.configurations.rust` |
| `;` → `:`, `;;` → `;` | `workspace::SendKeystrokes` to replay the keystroke — Zed doesn't have a raw remap primitive, but this does the same job |
| claudecode.nvim (`<leader>cc`, `<leader>ca`) | Zed's built-in Agent panel: `space c c` → `agent::ToggleFocus`, `space c a` → toggle the panel **and** send the current selection as context (`agent::AddSelectionToThread`) |
| gen.nvim (local Ollama prompt, `<leader>]`) | same Agent panel, since your `settings.json` already points `agent.default_model` at an Ollama model — `space ]` opens the panel with the selection attached |
| Telescope `find_files`, `builtin`, `diagnostics`, buffer switching | `space s f` → `file_finder::Toggle`, `space s s` → `command_palette::Toggle`, `space s d` → `diagnostics::Deploy`, `space space` → `tab_switcher::Toggle` |
| Telescope `live_grep` | `space s g` sends `ctrl-shift-f`, Zed's own project-wide search |
| `<leader>sn` (search nvim config) | repointed to `zed::OpenSettingsFile` as the nearest "edit my editor config" analog |
| `<leader>jq` (format JSON via jq) | JSON's formatter is now `jq .` (`"formatter": {"external": {"command": "jq", "arguments": ["."]}}`), and `space j q` runs `editor::Format` — this also means JSON auto-formats through jq on save |

## Gaps — no real Zed equivalent

These are genuine Neovim-plugin functionality with nothing to bind to on the
Zed side. Rather than fake a mapping, I left them out:

- **weasel-words highlighting** (`weasel.lua`, `<leader>tw`) — needs a custom
  regex-highlight layer with per-buffer state; Zed has no scripting API for
  this short of writing a Rust/Wasm extension.
- **undo tree** (`telescope-undo`, `<leader>u`) — Zed has linear undo/redo
  only, no visual undo-tree browser.
- **`w!!`** (sudo-write a protected file) — no shell-pipe-on-write hook in
  Zed. Workaround: use the integrated terminal (`ctrl-w t`) and run
  `sudo tee % > /dev/null` by hand, or edit the file as root from a terminal.
- **`<leader>x` / `<leader><leader>x`** (source the current Lua line/file) —
  not applicable; Zed has no in-editor scripting console.
- **`<leader>tf`** (toggle foldcolumn) — Zed doesn't expose a runtime toggle
  for gutter fold-icon visibility.
- **markdown-only `j`/`k` → `gj`/`gk`** — doable in principle via a
  language-scoped keymap context, but Zed's per-language vim context syntax
  isn't reliable enough for me to hand you a binding I'm confident works;
  worth checking `dev: open key context view` while in a Markdown buffer if
  you want to chase this down yourself.
- **Telescope `grep_string`, `resume`, `oldfiles`** — no exact equivalents.
  Closest workflow: select the word, then `space s g` for project search
  (Zed pre-fills the search box with your selection).
- **spellfile custom dictionary** (`spell/en.utf-8.add`) — Zed's spellcheck
  relies on the OS/browser-level checker, not a pluggable wordlist.

## Two things worth double-checking yourself

- `"agent": {"default_model": {"provider": "ollama", "model": "gemma4:12b-mlx"}}`
  was carried over unchanged from your existing settings — the model name
  looks like it might mix an Ollama tag with an MLX-style suffix; worth
  confirming that's actually what `ollama list` shows on your machine.
- Extensions still need installing from Zed's extension panel for
  Bash/Docker/YAML language servers (Zed doesn't use Mason — LSP binaries
  come bundled with each language extension).
