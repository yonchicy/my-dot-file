local vo=vim.o
local vg=vim.g
local vwo=vim.wo
local vbo=vim.bo
vim.cmd('set completeopt=menu,menuone,noselect')
vim.cmd('set mouse+=a')
vim.cmd('set clipboard=unnamed')
vim.cmd('set list')
vim.cmd('set backspace=indent,eol,start')
vim.o.number=true
-- vim.opt.spell = true
vim.opt.spelllang = {'en_us'}
vim.o.relativenumber=true
vim.o.cursorline=true
vim.o.cursorcolumn=true
vim.o.wrap=false
vim.g.syntax_on=true;


local log_path = vim.fn.stdpath('data')
vo.encoding="UTF-8"
vo.scrolloff=5
vo.undofile=true
vo.history=10000
vo.undolevels=1000
vo.undoreload=10000
vo.undodir=log_path..'/undo/'
vo.backupdir=log_path..'/backup/'
vo.directory=log_path..'/backup/'
vwo.number=true
vo.shiftround=true
vo.shiftwidth=4
vo.tabstop=4
vo.softtabstop=4
vo.hlsearch=true
vo.incsearch=true
vo.ignorecase=true
vo.smartcase=true



vim.api.nvim_exec([[
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
]],false)
