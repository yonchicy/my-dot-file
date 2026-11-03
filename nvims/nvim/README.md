# Neovim terminal workbench

This is a small Neovim 0.12 configuration for editing, searching, and managing
long-running CLI agents. It uses native `vim.pack` and installs
`nvim-mini/mini.nvim` (stable branch) plus `nvim-treesitter/nvim-treesitter`
(main branch).

## Requirements

- Neovim 0.12+
- `git` for the first plugin install
- `rg` for file and text search
- `curl`, `tar`, a C compiler, and `tree-sitter-cli` 0.26.1+ to install or
  update Tree-sitter parsers
- `codex` is optional, but enables the Codex convenience command

The first startup downloads managed plugins; later starts do not update them
automatically. Use `:packupdate` to review and apply updates.

## Syntax highlighting

Tree-sitter highlighting is enabled without LSP whenever Neovim can load a
matching parser and `highlights.scm` query. Filetypes without an available
parser keep their built-in syntax highlighting. Use `:Inspect` to see applied
highlight groups and `:InspectTree` to inspect the parsed syntax tree.

Lua uses Neovim's bundled parser. Java, C++, and Bash parsers are managed by
`nvim-treesitter`; Bash is also used for the `sh` filetype. Their generated
artifacts live in `.treesitter/`, which is intentionally ignored by Git. On a
new machine, run `:TSInstall bash cpp java`; after updating `nvim-treesitter`,
run `:TSUpdate` to keep parsers and queries compatible. Use
`:checkhealth nvim-treesitter` to diagnose parser installation problems.

## Core editing

The leader key is Space.

| Mapping | Action |
| --- | --- |
| `<leader>hl` | Clear search highlighting |
| `H` / `L` (Normal, Visual) | Move to the first non-blank character / end of line |
| `<leader>1` ... `<leader>9` | Focus a window by number |
| `<C-Left>` / `<C-Right>` | Narrow / widen the current window by 3 columns |
| `<Tab>` | Switch to the next buffer |
| `<S-Tab>` | Switch to the previous buffer |
| `<leader>bc` | Close the current buffer |
| `<leader>bn` | Create a new empty buffer |
| `<leader>q` | Save all buffers and quit the current window |

## Search and buffers

| Mapping | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fw` | Live full-text search |
| `<leader>fb` | Find open buffers |
| `<leader>e` | Toggle the file explorer at the current file |
| `<leader>E` | Browse the current working directory |

`mini.tabline` shows normal buffers and named terminal sessions in the top tab
line. Terminal badges mean: `●` running, `!` needs attention, `✓` completed,
`×` failed, and `+N` unread activity. File buffers use filetype icons; each
entry is separated by `│`, while the focused buffer has a `▌` marker and a
reversed, bold highlight. Terminal sessions use a terminal icon as well.

The file explorer uses `mini.files`: `h`/`l` navigate, `q` closes it, and a
preview is shown for the item under the cursor. Create, rename, move, or delete
entries by editing their lines, then press `=` to review and apply the changes.
Deletes go to mini.files' trash instead of being permanent.

## Terminal workbench

| Mapping | Action |
| --- | --- |
| `Jk` (Terminal) | Return to Normal mode |
| `<leader>tn` | Create a named terminal interactively |
| `<leader>tc` | Create a named Codex terminal |
| `<leader>tl` | Fuzzy-select a terminal session |
| `<leader>tt` | Focus or hide the last terminal |
| `<leader>th` | Hide the current terminal without stopping it |
| `<leader>ts` | Open the selected/current session as a bottom split |
| `<leader>tf` | Open it as a floating window |
| `<leader>to` | Open it in its own tabpage |
| `<leader>tx` | Stop the selected/current session |

New terminals open in their own tabpage by default. Use the explicit split,
float, or tab mappings above when reopening a session with a different layout.

In Terminal mode, use `Jk` or Neovim's built-in `<C-\\><C-n>` to return to
Normal mode before using the mappings. This configuration
intentionally does not override Esc, Ctrl-C, Enter, Tab, or common
terminal-control keys, so Codex and other TUIs keep their normal behavior.

### Commands

```vim
:AgentTermNew [name] [command]
:AgentTermNew! [name] [command]      " start in a float
:AgentTermCodex [name]
:AgentTermCodex! [name]              " start in a float
:AgentTermList
:AgentTermToggle
:AgentTermHide
:AgentTermOpen [name] [split|float|tab]
:AgentTermStop [name]
:AgentTermRename [new-name]
:AgentTermSend <name> <text>
```

Examples:

```vim
:AgentTermCodex api-fix
:AgentTermNew server npm run dev
:AgentTermNew logs tail -f ./app.log
:AgentTermOpen api-fix float
:AgentTermSend api-fix Please review the latest diff
```

A terminal process remains alive when its view is hidden. One process is shown
in only one window at a time: this avoids a single PTY receiving conflicting
sizes from a split and a float. If a session is already visible, opening it
focuses that view. To change its presentation, hide it first and then run
`AgentTermOpen` with the desired layout.

## Agent status and safety

Reliable states are process running, output while hidden, normal exit,
non-zero exit, and explicit stop. “Needs attention” is not a universal CLI
protocol, so it is only enabled through explicit profile matchers. The default
Codex matcher is deliberately conservative; customize it in
`lua/config/local.lua` after observing your CLI's wording.

The workbench never auto-confirms a prompt or sends input by itself.
`AgentTermSend` is the only command that writes to a terminal and always sends
an explicit line.

Neovim session restore is configured not to restart terminal jobs. If you need
agents to survive quitting Neovim, use tmux as the process-persistence layer;
that is intentionally a future backend rather than a fake native restore.

## Personal settings

Edit `lua/config/local.lua` to change the default layout, float/split sizes,
Codex command, or attention matchers. Set `icon_style = "glyph"` only if your
terminal uses a Nerd Font; this configuration uses mini.icons' Nerd Font 3
Material glyphs. Set it to `"ascii"` if the terminal cannot render them.
