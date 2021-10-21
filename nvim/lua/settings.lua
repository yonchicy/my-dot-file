local vo=vim.o
local vg=vim.g
local vwo=vim.wo
local vbo=vim.bo
vim.cmd('set completeopt=menu,menuone,noselect')
vim.cmd('set mouse+=a')
vim.cmd('set clipboard=unnamed')
vim.cmd('set backspace=indent,eol,start')
vim.o.number=true
vim.o.relativenumber=true
vim.o.cursorline=true
vim.o.cursorcolumn=true
vim.o.wrap=false
vim.g.syntax_on=true;

vo.encoding="UTF-8"
vo.scrolloff=5
vwo.number=true
vo.shiftround=true
vo.shiftwidth=4
vo.tabstop=4
vo.softtabstop=4
vo.hlsearch=true
vo.incsearch=true
vo.ignorecase=true
vo.smartcase=true


vim.cmd('hi HopNextKey guibg=#fabd2f guifg=#000000')
vim.cmd('hi HopNextKey1 guibg=#fabd2f guifg=#000000')
vim.cmd('hi HopUnmatched guifg=#928374' )
vim.api.nvim_exec([[
au TextYankPost * lua vim.highlight.on_yank {higroup="IncSearch", timeout=150, on_visual=true}
]],false)
