# Neovim terminal workbench

This is a small Neovim 0.12 configuration for editing, searching, and managing
long-running CLI agents. It uses native `vim.pack` and only installs
`nvim-mini/mini.nvim` (stable branch).

## Requirements

- Neovim 0.12+
- `git` for the first plugin install
- `rg` for file and text search
- `codex` is optional, but enables the Codex convenience command

The first startup downloads `mini.nvim`; later starts do not update plugins
automatically. Use `:packupdate` to review and apply updates.

## Search and buffers

| Mapping | Action |
| --- | --- |
| `<leader>ff` | Find files |
| `<leader>fg` | Live full-text search |
| `<leader>fb` | Find open buffers |

`mini.tabline` shows normal buffers and named terminal sessions in the top tab
line. Terminal badges mean: `●` running, `!` needs attention, `✓` completed,
`×` failed, and `+N` unread activity.

## Terminal workbench

| Mapping | Action |
| --- | --- |
| `<leader>tn` | Create a named terminal interactively |
| `<leader>tc` | Create a named Codex terminal |
| `<leader>tl` | Fuzzy-select a terminal session |
| `<leader>tt` | Focus or hide the last terminal |
| `<leader>th` | Hide the current terminal without stopping it |
| `<leader>ts` | Open the selected/current session as a bottom split |
| `<leader>tf` | Open it as a floating window |
| `<leader>to` | Open it in its own tabpage |
| `<leader>tx` | Stop the selected/current session |

In Terminal mode, use Neovim's built-in `<C-\\><C-n>` to return to Normal
mode before using the mappings. This configuration intentionally does not
override Esc, Ctrl-C, Enter, Tab, or common terminal-control keys, so Codex and
other TUIs keep their normal behavior.

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
terminal uses a Nerd Font; otherwise the ASCII default is intentional.
