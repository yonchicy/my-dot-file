
local opt = vim.opt
local g = vim.g

opt.rnu=true
opt.scrolloff=8
opt.sidescrolloff=8
opt.wrap=false
opt.tabstop=4
opt.shiftwidth=4
opt.expandtab=true

-- opt.guifont = "CodeNewRoman Nerd Font:h15" -- the font used in graphical neovim applications

-- hilight yank
vim.api.nvim_exec([[
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
]],false)

g.neovide_cursor_vfx_mode = "railgun"
-- g.neovide_transparency = 0.7


require("custom.scripts.asyncrun")


