" Minimal reader-oriented Vim: works on stock Vim over SSH.
set nocompatible
set encoding=utf-8
set relativenumber
set hlsearch
set incsearch
set nowrap
set ignorecase smartcase
set hidden
set showtabline=2
set laststatus=2
set wildmenu
set wildmode=longest:full,full
set mouse=a
set scrolloff=5
set synmaxcol=240
set backspace=indent,eol,start
set splitright
set splitbelow

let mapleader = " "

:imap jk <ESC>
:nmap H ^
:nmap L $
:vmap H ^
:vmap L $
:nmap <c-h> <c-w>h
:nmap <c-l> <c-w>l
:nmap <c-k> <c-w>k
:nmap <c-j> <c-w>j

" vim-plug: one-file manager, no extra runtime.
let s:plug_path = expand('~/.vim/autoload/plug.vim')
if empty(glob(s:plug_path)) && executable('curl')
  silent execute '!curl -fLo '.shellescape(s:plug_path).' --create-dirs '
        \ .'https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim'
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.vim/plugged')

" fzf (Go): async fuzzy finder. Faster and more portable than LeaderF / vim-clap
" on servers. :Files / :Buffers / :Rg / :BLines / :History.
Plug 'junegunn/fzf', { 'do': { -> fzf#install() } }
Plug 'junegunn/fzf.vim'

" Buffer tabs in the tabline. Pure Vimscript, no fonts / statusline framework.
Plug 'ap/vim-buftabline'

call plug#end()

" --- fzf ---
if executable('fd')
  let $FZF_DEFAULT_COMMAND = 'fd --type f --hidden --follow --exclude .git'
elseif executable('rg')
  let $FZF_DEFAULT_COMMAND = 'rg --files --hidden --follow --glob "!.git"'
endif

" Popup on Vim 8.2+ / Neovim; split layout on older server Vims.
if has('nvim-0.4') || has('popupwin')
  let g:fzf_layout = { 'window': { 'width': 0.9, 'height': 0.6 } }
else
  let g:fzf_layout = { 'down': '40%' }
endif

let g:fzf_action = {
  \ 'ctrl-t': 'tab split',
  \ 'ctrl-x': 'split',
  \ 'ctrl-v': 'vsplit' }

let g:fzf_vim = {}
" Preview on the right when wide enough; Ctrl-/ toggles it.
let g:fzf_vim.preview_window = ['right,50%,<70(up,40%)', 'ctrl-/']

nnoremap <silent> <C-p>      :Files<CR>
nnoremap <silent> <leader>f  :Files<CR>
nnoremap <silent> <leader>b  :Buffers<CR>
nnoremap <silent> <leader>r  :History<CR>
nnoremap <silent> <leader>l  :BLines<CR>
nnoremap <silent> <leader>g  :Rg<CR>

" --- tabs / buffers ---
" buftabline shows listed buffers; Vim tab pages stay available via :tabnew / gt.
let g:buftabline_numbers = 2
let g:buftabline_indicators = 1

nnoremap <silent> <Tab>      :bnext<CR>
nnoremap <silent> <S-Tab>    :bprevious<CR>
nnoremap <silent> ]b         :bnext<CR>
nnoremap <silent> [b         :bprevious<CR>
nnoremap <silent> <leader>tn :tabnew<CR>
nnoremap <silent> <leader>tc :tabclose<CR>
nnoremap <silent> <leader>d  :bdelete<CR>

nmap <leader>1 <Plug>BufTabLine.Go(1)
nmap <leader>2 <Plug>BufTabLine.Go(2)
nmap <leader>3 <Plug>BufTabLine.Go(3)
nmap <leader>4 <Plug>BufTabLine.Go(4)
nmap <leader>5 <Plug>BufTabLine.Go(5)
nmap <leader>6 <Plug>BufTabLine.Go(6)
nmap <leader>7 <Plug>BufTabLine.Go(7)
nmap <leader>8 <Plug>BufTabLine.Go(8)
nmap <leader>9 <Plug>BufTabLine.Go(9)
