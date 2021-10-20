local vo=vim.o
local vg=vim.g
local vwo=vim.wo
local vbo=vim.bo
vim.cmd('set completeopt=menu,menuone,noselect')
vim.cmd('set mouse+=a')
vim.cmd('set clipboard=unnamed')
vim.cmd('set backspace=indent,eol,start')
vim.cmd('colorscheme gruvbox')
vim.cmd('hi LineNr guifg=#DFFF00')
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
vo.termguicolors=true


vim.cmd('hi HopNextKey guibg=#fabd2f guifg=#000000')
vim.cmd('hi HopNextKey1 guibg=#fabd2f guifg=#000000')
vim.cmd('hi HopUnmatched guifg=#928374' )
vim.cmd('hi Search guibg=#fabd2f guifg=#000000' )
