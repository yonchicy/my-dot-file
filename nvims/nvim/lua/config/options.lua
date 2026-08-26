vim.g.mapleader = " "
vim.g.maplocalleader = " "

local opt = vim.opt

opt.number = true
opt.relativenumber = true
opt.mouse = "a"
opt.termguicolors = true
opt.splitbelow = true
opt.splitright = true
opt.ignorecase = true
opt.smartcase = true
opt.signcolumn = "yes"
opt.scrolloff = 4
opt.sidescrolloff = 4
opt.updatetime = 250
opt.timeoutlen = 400
opt.undofile = true
opt.confirm = true
opt.laststatus = 3
opt.showmode = false
opt.cursorline = true

-- A restored Neovim session would otherwise restart `term://` commands. That
-- is unsafe for long-running agents: their persistence belongs to tmux, not a
-- blind :mksession replay.
opt.sessionoptions:remove("terminal")
