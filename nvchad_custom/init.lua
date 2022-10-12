-- example file i.e lua/custom/init.lua
-- load your options globals, autocmds here or anything .__.
-- you can even override default options here (core/options.lua)


local opt = vim.opt

opt.rnu=true
opt.scrolloff=8
opt.sidescrolloff=8



-- hilight yank
vim.api.nvim_exec([[
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
]],false)



require("custom.scripts.asyncrun")

