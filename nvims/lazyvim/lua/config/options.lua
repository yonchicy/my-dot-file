-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here
vim.opt.background = "dark"

local opt = vim.opt
local g = vim.g

opt.nu = true
opt.scrolloff = 8
opt.sidescrolloff = 8
opt.wrap = false
opt.tabstop = 2
opt.shiftwidth = 2
opt.expandtab = true
opt.wildmode = { "longest", "list:full" }
-- opt.guifont = "CodeNewRoman Nerd Font:h15" -- the font used in graphical neovim applications

-- hilight yank
vim.api.nvim_create_autocmd("TextYankPost", { callback = function() vim.highlight.on_yank({ higroup = 'IncSearch', timeout = 150,on_visual=true }) end })

g.neovide_cursor_vfx_mode = "railgun"
g.autoformat = false
-- g.neovide_transparency = 0.7

