local opt = vim.opt
local g = vim.g

opt.wrap = false
opt.scrolloff=8
opt.sidescrolloff=8
-- vim.api.nvim_exec([[
-- :autocmd CursorMoved,CursorMovedI * normal zz
-- ]],false)

opt.title = true
opt.clipboard = "unnamedplus"
opt.cul=true
opt.swapfile=false
opt.signcolumn="yes"

opt.colorcolumn = "99999"
if g.nvui then
vim.cmd[[NvuiCmdFontFamily FiraCode\ Nerd\ Font:h17]]
else
vim.cmd[[set guifont=JetBrainsMono\ Nerd\ Font:h10]]
    -- opt.guifont = "FiraCode Nerd Font:h17" -- the font used in graphical neovim applications
end

-- Indentline
opt.expandtab = true
opt.shiftwidth = 4
opt.smartindent = true


opt.hidden = true
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Line Numbers
opt.number = true
opt.numberwidth = 2
opt.relativenumber = true
opt.ruler =true

-- disable nvim intro

opt.tabstop = 4
opt.termguicolors=true

opt.timeoutlen=400
opt.undofile = true

opt.updatetime = 250

opt.whichwrap:append "<>[]hl"
g.mapleader = " "

opt.list = true
opt.listchars:append("space:⋅")
opt.listchars:append("eol:↴")

g.rainbow_active = 1


local disabled_built_ins = {
   "2html_plugin",
   "getscript",
   "getscriptPlugin",
   "gzip",
   "logipat",
   "netrw",
   "netrwPlugin",
   "netrwSettings",
   "netrwFileHandlers",
   "matchit",
   "tar",
   "tarPlugin",
   "rrhelper",
   "spellfile_plugin",
   "vimball",
   "vimballPlugin",
   "zip",
   "zipPlugin",
}

for _, plugin in pairs(disabled_built_ins) do
   g["loaded_" .. plugin] = 1
end

vim.opt.shadafile = "NONE"
vim.schedule(function()
   vim.cmd [[ silent! rsh ]]
end)

-- hilight yank
vim.api.nvim_exec([[
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
]],false)
