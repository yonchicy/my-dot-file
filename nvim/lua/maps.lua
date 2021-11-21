vim.g.mapleader=' '
vim.api.nvim_set_keymap('i','jk','<esc>:wa<cr>',{})
vim.api.nvim_set_keymap('i','df','<c-o>a',{})
vim.api.nvim_set_keymap('i','<c-b>','<c-o>h',{})
vim.api.nvim_set_keymap('i','<c-e>','<c-o>A',{})
vim.api.nvim_set_keymap('i','<c-a>','<c-o>I',{})
vim.api.nvim_set_keymap('i','<c-f>','<c-o>a',{})
vim.api.nvim_set_keymap('i','<c-n>','<c-o>j',{})
vim.api.nvim_set_keymap('i','<c-p>','<c-o>k',{})
vim.api.nvim_set_keymap('n','wq',':wa<cr>:q<cr>',{})
vim.api.nvim_set_keymap('n','<c-j>',':bprev<cr>',{})
vim.api.nvim_set_keymap('n','<c-k>',':bnext<cr>',{})
vim.api.nvim_set_keymap('n','<leader>bd',':bdelete<cr>',{})
vim.api.nvim_set_keymap('n','<c-w>',':bdelete<cr>',{})
vim.api.nvim_set_keymap('n','L','$',{})
vim.api.nvim_set_keymap('n','H','^',{noremap=true})
vim.api.nvim_set_keymap('n','ga','<Plug>(EasyAlign)',{})
vim.api.nvim_set_keymap('n','<c-_>','Vgc',{})
vim.api.nvim_set_keymap('n','<leader>cl','Vgc',{})
vim.api.nvim_set_keymap('n','<leader>cp','vipgc',{})
vim.api.nvim_set_keymap('v','<leader>cl','gc',{})
-- vim.api.nvim_set_keymap('n','<leader>b',':Telescope buffers<cr>',{})
vim.api.nvim_set_keymap('n','Q','<Nop>',{})
vim.api.nvim_set_keymap('n','<leader>wv',':vsp<cr>',{})
vim.api.nvim_set_keymap('n','<leader>ws',':sp<cr>',{})
vim.api.nvim_set_keymap('n',';g',':vsp<cr>',{})
vim.api.nvim_set_keymap('n',';vg',':sp<cr>',{})
vim.api.nvim_set_keymap('n','<leader>1','1<c-w>w',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>2','2<c-w>w',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>3','3<c-w>w',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>4','4<c-w>w',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>5','5<c-w>w',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>6','6<c-w>w',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>7','7<c-w>w',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>8','8<c-w>w',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>9','9<c-w>w',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>hl',':nohl<cr>',{})
vim.api.nvim_set_keymap('v','L','$',{})
vim.api.nvim_set_keymap('v','H','^',{noremap=true})
vim.api.nvim_set_keymap('v','ga','<Plug>(EasyAlign)',{})
vim.api.nvim_set_keymap('v','<c-_>','gc',{})
vim.api.nvim_set_keymap('x','ga','<Plug>(EasyAlign)',{})
-- fzf finders
vim.api.nvim_set_keymap('','<c-p>','<cmd>Telescope find_files<cr>',{noremap=true})
vim.api.nvim_set_keymap('','<leader>/','<cmd>Telescope find_files<cr>',{noremap=true})
vim.api.nvim_set_keymap('','<leader>ss',':Telescope lsp_workspace_symbols<cr>',{noremap=true})
vim.api.nvim_set_keymap('','<leader>st',':SymbolsOutline<cr>',{noremap=true})
vim.api.nvim_set_keymap('','<leader>sr',':Telescope lsp_references<cr>',{noremap=true})
vim.api.nvim_set_keymap('','<leader>scs',':Telescope lsp_document_symbols<cr>',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>sw',':Telescope live_grep<cr>',{noremap=true})
vim.api.nvim_set_keymap('n','<leader>S',':Rg <c-r><c-w><cr>',{noremap=true})


--  easymotion
vim.api.nvim_set_keymap('','<leader>f','<cmd>HopChar1<cr>',{})
vim.api.nvim_set_keymap('','<leader>l','<cmd>HopLineStart<cr>',{})
vim.api.nvim_set_keymap('','<leader>j','<cmd>HopLineStart<cr>',{})
vim.api.nvim_set_keymap('','<leader>k','<cmd>HopLineStart<cr>',{})
vim.api.nvim_set_keymap('','vn','<cmd>HopChar2<cr>',{})



-- bufferline
-- vim.api.nvim_set_keymap('n','<leader>b',':BufferLinePick<cr>',{})
vim.api.nvim_set_keymap('n','<leader>tra',':RnvimrToggle<CR>',{})
vim.api.nvim_set_keymap('n','<c-b>',':NvimTreeToggle<CR>',{})
vim.api.nvim_set_keymap('n','<f5>',':!ctags -R<CR><CR>',{})


-- move code block
--

vim.api.nvim_set_keymap('n','<a-j>',':m .+1<cr>==',{noremap=true})
vim.api.nvim_set_keymap('n','<a-k>',':m .-2<cr>==',{noremap=true})
vim.api.nvim_set_keymap('v','<a-j>',":m '>+1<cr>gv=gv",{noremap=true})
vim.api.nvim_set_keymap('v','<a-k>',":m '<-2<cr>gv=gv",{noremap=true})
vim.api.nvim_set_keymap('v','>',">gv",{noremap=true})

vim.api.nvim_set_keymap('v','<',"<gv",{noremap=true})
