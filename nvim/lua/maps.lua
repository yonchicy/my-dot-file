local map=vim.api.nvim_set_keymap


vim.g.mapleader=' '
vim.api.nvim_set_keymap('i','jk','<esc>',{})
vim.api.nvim_set_keymap('i','df','<c-o>a',{})
vim.api.nvim_set_keymap('n','wq',':wa<cr>:q<cr>',{})
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



--  easymotion
vim.api.nvim_set_keymap('','<leader>','<Plug>(easymotion-prefix)',{})
vim.api.nvim_set_keymap('n','<leader>hl',':nohl<cr>',{})


