

vim.g.mapleader=' '
vim.api.nvim_set_keymap('i','jk','<esc>',{})
vim.api.nvim_set_keymap('i','df','<c-o>a',{})
vim.api.nvim_set_keymap('i','<c-b>','<c-o>h',{})
vim.api.nvim_set_keymap('i','<c-f>','<c-o>h',{})
vim.api.nvim_set_keymap('i','<c-n>','<c-o>j',{})
vim.api.nvim_set_keymap('i','<c-p>','<c-o>k',{})
vim.api.nvim_set_keymap('n','wq',':wa<cr>:q<cr>',{})
vim.api.nvim_set_keymap('n','wq',':wa<cr>:q<cr>',{})
vim.api.nvim_set_keymap('n','<c-j>',':bprev<cr>',{})
vim.api.nvim_set_keymap('n','<c-k>',':bnext<cr>',{})
vim.api.nvim_set_keymap('n','<leader>bd',':bdelete<cr>',{})
vim.api.nvim_set_keymap('n','<f3>',':NERDTree<cr>',{})
vim.api.nvim_set_keymap('n','L','$',{})
vim.api.nvim_set_keymap('n','H','^',{})
vim.api.nvim_set_keymap('v','L','$',{})
vim.api.nvim_set_keymap('v','H','^',{})
vim.api.nvim_set_keymap('v','ga','<Plug>(EasyAlign)',{})
vim.api.nvim_set_keymap('x','ga','<Plug>(EasyAlign)',{})
vim.api.nvim_set_keymap('n','ga','<Plug>(EasyAlign)',{})
vim.api.nvim_set_keymap('v','<leader>cl','gc',{})
vim.api.nvim_set_keymap('n','<leader>cl','Vgc',{})
vim.api.nvim_set_keymap('n','<c-p>',':Telescope find_files<cr>',{})
vim.api.nvim_set_keymap('n','<leader>s',':Telescope live_grep<cr>',{})
vim.api.nvim_set_keymap('n','<leader>b',':Telescope buffers<cr>',{})
vim.api.nvim_set_keymap('n','Q','<Nop>',{})
vim.api.nvim_set_keymap('n',';g',':vsp<cr>',{})
vim.api.nvim_set_keymap('n',';vg',':sp<cr>',{})
vim.api.nvim_set_keymap('n','<leader>1','1<c-w>w',{})
vim.api.nvim_set_keymap('n','<leader>2','2<c-w>w',{})
vim.api.nvim_set_keymap('n','<leader>3','3<c-w>w',{})
vim.api.nvim_set_keymap('n','<leader>4','4<c-w>w',{})
vim.api.nvim_set_keymap('n','<leader>5','5<c-w>w',{})
vim.api.nvim_set_keymap('n','<leader>6','6<c-w>w',{})
vim.api.nvim_set_keymap('n','<leader>7','7<c-w>w',{})
vim.api.nvim_set_keymap('n','<leader>8','8<c-w>w',{})
vim.api.nvim_set_keymap('n','<leader>9','9<c-w>w',{})



--  easymotion
vim.api.nvim_set_keymap('','<leader>','<Plug>(easymotion-prefix)',{})
vim.api.nvim_set_keymap('n','<leader>hl',':nohl<cr>',{})


