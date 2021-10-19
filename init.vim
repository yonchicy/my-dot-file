" Comments in Vimscript start with a `"`.

call plug#begin('~/.vim/plugged')

Plug 'tomasr/molokai'
Plug 'morhetz/gruvbox'
Plug 'vim-airline/vim-airline'
Plug 'altercation/vim-colors-solarized'
Plug 'jiangmiao/auto-pairs'
Plug 'bling/vim-bufferline'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-commentary'
Plug 'easymotion/vim-easymotion'
Plug 'haya14busa/incsearch.vim'
Plug 'unblevable/quick-scope'
Plug 'rhysd/clever-f.vim'
Plug 'preservim/nerdtree'
Plug 'psliwka/vim-smoothie'
Plug 'junegunn/vim-easy-align'
Plug 'junegunn/fzf.vim'
Plug 'junegunn/fzf',{'do': {-> fzf#install()}}
Plug 'frazrepo/vim-rainbow'
Plug 'skywind3000/vim-auto-popmenu'
Plug 'rust-lang/rust.vim'
" Plug 'terryma/vim-multiple-cursors'
Plug 'vim-syntastic/syntastic'
Plug 'vim-scripts/argtextobj.vim'
Plug 'neoclide/coc.nvim',{'branch':'release'}

call plug#end()


" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible
set nowrap
let mapleader=" "
" {
"     }
"

set shortmess+=I
set hlsearch
" Turn on syntax highlighting.
colorscheme molokai
" colorscheme solarized
colorscheme gruvbox
set background=dark
" let g:molokai_original=1
syntax on
syntax enable
set termguicolors


set clipboard=unnamed
" :highlight LineNr guifg=#DFFF00
" :highlight Visual guibg=#333333
" :highlight VisualNOS guibg=#333333
" Disable the default Vim startup message.
" Show line numbers.
set number
" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase

" Enable searching as you type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a
nmap <c-p> :Files<CR>
nmap <leader>s :Rg<CR>
nmap gd :Rg <c-r><c-w><CR>
" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
nnoremap H ^
nnoremap L $
vnoremap H ^
vnoremap L $
set cursorline
set cursorcolumn

" If you open this file in Vim, it'll be syntax highlighted for you.

" Vim is based on Vi. Setting `nocompatible` switches from the default
" Vi-compatibility mode and enables useful Vim functionality. This
" configuration option turns out not to be necessary for the file named
" '~/.vimrc', because Vim automatically enters nocompatible mode if that file
" is present. But we're including it here just in case this config file is
" loaded some other way (e.g. saved as `foo`, and then Vim started with
" `vim -u foo`).
set nocompatible
filetype plugin indent on
" show existing tab with 4 spaces width
set tabstop=4
" when indenting with '>', use 4 spaces width
set shiftwidth=4
" On pressing tab, insert 4 spaces
set expandtab


" Turn on syntax highlighting.
syntax on
syntax enable
" Disable the default Vim startup message.
set shortmess+=I
:highlight LineNr guifg=#DFFF00
" Show line numbers.
set number

" This enables relative line numbering mode. With both number and
" relativenumber enabled, the current line shows the true line number, while
" all other lines (above and below) are numbered relative to the current line.
" This is useful because you can tell, at a glance, what count is needed to
" jump up or down to a particular line, by {count}k to go up or {count}j to go
" down.
set relativenumber

" Always show the status line at the bottom, even if you only have one window open.
set laststatus=2

" The backspace key has slightly unintuitive behavior by default. For example,
" by default, you can't backspace before the insertion point set with 'i'.
" This configuration makes backspace behave more reasonably, in that you can
" backspace over anything.
set backspace=indent,eol,start

" By default, Vim doesn't let you hide a buffer (i.e. have a buffer that isn't
" shown in any window) that has unsaved changes. This is to prevent you from "
" forgetting about unsaved changes and then quitting e.g. via `:qa!`. We find
" hidden buffers helpful enough to disable this protection. See `:help hidden`
" for more information on this.
set hidden

" This setting makes search case-insensitive when all characters in the string
" being searched are lowercase. However, the search becomes case-sensitive if
" it contains any capital letters. This makes searching more convenient.
set ignorecase
set smartcase
" Enable searching as yu type, rather than waiting till you press enter.
set incsearch

" Unbind some useless/annoying default key bindings.
nmap Q <Nop> " 'Q' in normal mode enters Ex mode. You almost never want this.

" Disable audible bell because it's annoying.
set noerrorbells visualbell t_vb=

" Enable mouse support. You should avoid relying on this too much, but it can
" sometimes be convenient.
set mouse+=a

" Try to prevent bad habits like using the arrow keys for movement. This is
" not the only possible bad habit. For example, holding down the h/j/k/l keys
" for movement, rather than using more efficient movement commands, is also a
" bad habit. The former is enforceable through a .vimrc, while we don't know
" how to prevent the latter.
" Do this in normal mode...
nnoremap <Left>  :echoe "Use h"<CR>
nnoremap <Right> :echoe "Use l"<CR>
nnoremap <Up>    :echoe "Use k"<CR>
nnoremap <Down>  :echoe "Use j"<CR>
" ...and in insert mode
inoremap <Left>  <ESC>:echoe "Use h"<CR>
inoremap <Right> <ESC>:echoe "Use l"<CR>
inoremap <Up>    <ESC>:echoe "Use k"<CR>
inoremap <Down>  <ESC>:echoe "Use j"<CR>
"nnoremap H ^
"nnoremap L $
set guifont=Source\ Code\ Pro\ semibold\ 16
map <Leader> <Plug>(easymotion-prefix)
" map / <Plug>(easymotion-sn)
" omap / <Plug>(easymotion-tn)

" 定义跳出括号函数，用于跳出括号
func SkipPair()
    if getline('.')[col('.') - 1] == ')' || getline('.')[col('.') - 1] == ']' || getline('.')[col('.') - 1] == '"' || getline('.')[col('.') - 1] == "'" || getline('.')[col('.') - 1] == '}'
        return "\<ESC>la"
    else
        return "\t"
    endif
endfunc
" 将tab键绑定为跳出括号
inoremap <tab> <c-r>=SkipPair()<CR>
nnoremap <f5> :!ctags -R<CR>
nnoremap ;g :vsp<CR>
nnoremap ;vg :sp<CR>
imap jk <esc>:w<cr>
imap <c-b> <c-o>h
imap <c-n> <c-o>j
imap <c-p> <c-o>k
nnoremap wq :wa<CR>:q<CR>


" plugins
let g:deoplete#enable_at_startup = 1

set hidden
imap df <c-o>a
imap <c-f> <c-o>a
nnoremap <c-j> :bprev<CR>
nnoremap <c-k> :bnext<CR>
noremap <leader>bd :bdelete<CR>
vmap <leader>cl gc
nmap <leader>cl Vgc
let g:airline_powerline_fonts = 1
let g:Lf_ShortcutF = '<c-p>'


let g:clever_f_across_no_line=1
let g:rainbow_active=1

nnoremap <F3> :NERDTree<CR>
:autocmd InsertEnter * set nocursorline
:autocmd InsertLeave * set cursorline
:autocmd InsertEnter * set nocursorcolumn
:autocmd InsertLeave * set cursorcolumn
" let g:airline_section_a = '%{winnr()}'
" let g:airline_section_b = '%{winnr()}'
let g:airline_section_c = ''
let g:airline_section_y = '%{strftime("%H:%M")}'
let g:airline#extensions#tabline#enabled = 1
function! WindowNumber(...)
    let builder = a:1
    let context = a:2
    call builder.add_section('airline_b','%{winnr()}')
    return 0
endfunction

call airline#add_statusline_func('WindowNumber')
call airline#add_inactive_statusline_func('WindowNumber')


nnoremap <Leader>1 1<c-w>w
nnoremap <Leader>2 2<c-w>w
nnoremap <Leader>3 3<c-w>w
nnoremap <Leader>4 4<c-w>w
nnoremap <Leader>5 5<c-w>w
nnoremap <Leader>6 6<c-w>w
nnoremap <Leader>7 7<c-w>w
nnoremap <Leader>8 8<c-w>w
nnoremap <Leader>9 9<c-w>w
nnoremap <Leader>hl :nohls<CR>

" menupop select
" set cpt=.,k,w,b
" set completeopt=menu,menuone,noselect
" set shortmess+=c

set scrolloff=5

xmap ga <Plug>(EasyAlign)
vmap ga <Plug>(EasyAlign)
nmap ga <Plug>(EasyAlign)

inoremap <silent><expr> <TAB>
            \ pumvisible()? coc#_select_confirm():
            \coc#expandableOrJumpable()?"\<C-r>=coc#rpc#request('doKeymap',['snippets-expand-jump',''])\<CR>":
            \<SID>check_back_space()?"\<TAB>":
            \coc#refresh()
function! s:check_back_space()abort
    let col=col('.')-1
    return !col||getline('.')[col-1] =~# '\s'
endfunction
let g:coc_snippet_next='<tab>'
imap <c-l> <Plug>(coc-snippets-expand)
autocmd CursorHold * silent call CocActionAsync('highlight')


let g:fzf_preview_window = ['right:50%','ctrl-/']
let g:fzf_layout = {'down':'50%'}
