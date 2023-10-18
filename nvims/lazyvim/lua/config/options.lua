-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

local opt = vim.opt
local g = vim.g

opt.rnu = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.wildmode = { "longest", "list:full" }
-- opt.guifont = "CodeNewRoman Nerd Font:h15" -- the font used in graphical neovim applications

-- hilight yank
vim.api.nvim_exec(
  [[
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
]],
  false
)

g.neovide_cursor_vfx_mode = "railgun"
g.autoformat = false
opt.background = "dark"
-- g.neovide_transparency = 0.7
