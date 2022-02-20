local M = {}



M.hop = function()
    require 'hop'.setup { keys = 'etovxqpdygfblzhckisuran' }
    vim.api.nvim_set_keymap('n', '<leader>f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
    vim.api.nvim_set_keymap('n', '<leader>F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {})
    vim.api.nvim_set_keymap('o', '<leader>f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
    vim.api.nvim_set_keymap('o', '<leader>F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})
    vim.api.nvim_set_keymap('', '<leader>l', '<cmd>HopLineStart<cr>', {})
    vim.api.nvim_set_keymap('', '<leader>j', '<cmd>HopLineStart<cr>', {})
    vim.api.nvim_set_keymap('', '<leader>k', '<cmd>HopLineStart<cr>', {})
    vim.cmd('hi HopNextKey guibg=#fabd2f guifg=#000000')
    vim.cmd('hi HopNextKey1 guibg=#fabd2f guifg=#000000')
    vim.cmd('hi HopUnmatched guifg=#928374')
end


return M
