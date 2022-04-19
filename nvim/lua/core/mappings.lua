local cmd = vim.cmd
local options = { noremap = true, silent = true }

local M = {}

M.core_mappings = function()
    vim.api.nvim_set_keymap('n', '<leader>cc', "<cmd>lua require('colors').set_random_theme()<CR>", { noremap = true, silent = true })
    vim.api.nvim_set_keymap('i', 'jk', '<esc>', options)
    vim.api.nvim_set_keymap('n', 'Q', '<nop>', options)
    vim.api.nvim_set_keymap('n', '<leader>hl', ':nohl<CR>', options)

    vim.api.nvim_set_keymap('n', 'Y', 'yg$', options)
    -- don't let 'x' or 's' pollute register
    -- vim.api.nvim_set_keymap('n', 's', '"_s', options)
    -- vim.api.nvim_set_keymap('v', 's', '"_s', options)
    -- vim.api.nvim_set_keymap('n', 'x', '"_x', options)
    -- vim.api.nvim_set_keymap('v', 'x', '"_x', options)

    -- emacs key / insert key
    vim.api.nvim_set_keymap('i', '<c-a>', '<c-o>^', options)
    vim.api.nvim_set_keymap('i', '<c-e>', '<c-o>$', options)
    vim.api.nvim_set_keymap('i', '<c-p>', '<c-o>k', options)
    vim.api.nvim_set_keymap('i', '<c-n>', '<c-o>j', options)
    vim.api.nvim_set_keymap('i', '<c-f>', '<c-o>a', options)
    vim.api.nvim_set_keymap('i', 'df', '<c-o>a', options)

    -- windows navigation

    vim.api.nvim_set_keymap('n', '<leader>1', '1<c-w>w', options)
    vim.api.nvim_set_keymap('n', '<leader>2', '2<c-w>w', options)
    vim.api.nvim_set_keymap('n', '<leader>3', '3<c-w>w', options)
    vim.api.nvim_set_keymap('n', '<leader>4', '4<c-w>w', options)
    vim.api.nvim_set_keymap('n', '<leader>5', '5<c-w>w', options)
    vim.api.nvim_set_keymap('n', '<leader>6', '6<c-w>w', options)
    vim.api.nvim_set_keymap('n', '<leader>7', '7<c-w>w', options)
    vim.api.nvim_set_keymap('n', '<leader>8', '8<c-w>w', options)
    vim.api.nvim_set_keymap('n', '<leader>9', '9<c-w>w', options)

    -- buffer
    vim.api.nvim_set_keymap('n', '<leader>bc', ":lua require('core.utils').close_buffer() <CR>", options)
    vim.api.nvim_set_keymap('n', '<leader>bn', ':enew<CR>', options)
    vim.api.nvim_set_keymap('n', '<leader>q', ':wa!<CR>:q<CR>', options)

    --terminal
    vim.api.nvim_set_keymap('t', 'jk', "<c-\\><c-n>", options)
    vim.api.nvim_set_keymap('t', 'JK', "<c-\\><c-n>:bd!<cr>", options)
    vim.api.nvim_set_keymap("n", "<leader>th", ":execute 15 .. 'new +terminal' | let b:term_type = 'hori' | startinsert <CR><c-\\><c-n><c-w>ri", options)
    vim.api.nvim_set_keymap("n", "<leader>tv", ":execute 'vnew +terminal' | let b:term_type = 'vert' | startinsert <CR>jk<c-w>ri", options)
    vim.api.nvim_set_keymap("n", "<leader>tw", ":execute 'terminal' | let b:term_type = 'wind' | startinsert <CR>", options)

    -- windows
    vim.api.nvim_set_keymap("n", "<c-left>", "3<c-w><", options)
    vim.api.nvim_set_keymap("n", "<c-right>", "3<c-w>>", options)
    -- Add Packer commands because we are not loading it at startup
    cmd "silent! command PackerClean lua require 'plugins' require('packer').clean()"
    cmd "silent! command PackerCompile lua require 'plugins' require('packer').compile()"
    cmd "silent! command PackerInstall lua require 'plugins' require('packer').install()"
    cmd "silent! command PackerStatus lua require 'plugins' require('packer').status()"
    cmd "silent! command PackerSync lua require 'plugins' require('packer').sync()"
    cmd "silent! command PackerUpdate lua require 'plugins' require('packer').update()"

    cmd "silent! command DebugMode echo 'begin debug'"
    --motion
    vim.api.nvim_set_keymap("n", "H", "^", options)
    vim.api.nvim_set_keymap("v", "H", "^", options)
    vim.api.nvim_set_keymap("n", "L", "$", options)
    vim.api.nvim_set_keymap("v", "L", "$", options)
end

M.telescope = function()
    vim.api.nvim_set_keymap("n", "<leader>sb", ":Telescope buffers <CR>", options)
    vim.api.nvim_set_keymap("n", "<c-p>", ":Telescope find_files <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>sf", ":Telescope find_files <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>shf", ":Telescope find_files follow=true no_ignore=true hidden=true <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>sgc", ":Telescope git_commits <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>sgs", ":Telescope git_status <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>scs", ":Telescope lsp_document_symbols <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>ss", ":Telescope lsp_workspace_symbols <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>sw", ":Telescope live_grep <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>sm", ":Telescope harpoon marks <CR>", options)
    vim.api.nvim_set_keymap('n', '<leader>S', ':lua require("telescope.builtin").grep_string()<cr>', options)
    -- vim.api.nvim_set_keymap("n", m.oldfiles, ":Telescope oldfiles <CR>")
    vim.api.nvim_set_keymap("n", "<leader>sc", ":Telescope themes <CR>", options)
end

M.bufferline = function()

    vim.api.nvim_set_keymap("n", "<Tab>", ":BufferLineCycleNext <CR>", options)
    vim.api.nvim_set_keymap("n", "<S-Tab>", ":BufferLineCyclePrev <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>bp", ":BufferLinePick <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>b1", ":BufferLineGoToBuffer 1 <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>b2", ":BufferLineGoToBuffer 2 <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>b3", ":BufferLineGoToBuffer 3 <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>b4", ":BufferLineGoToBuffer 4 <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>b5", ":BufferLineGoToBuffer 5 <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>b6", ":BufferLineGoToBuffer 6 <CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>b7", ":BufferLineGoToBuffer 7 <CR>", options)

end

M.nvimtree = function()
    vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeToggle <CR>", options)
    -- vim.api.nvim_set_keymap("n", "<leader>e", ":NvimTreeFocus <CR>")
end
M.lspconfig = function()

    -- See `:help vim.lsp.*` for documentation on any of the below functions
    vim.api.nvim_set_keymap("n", "gD", "<cmd>lua vim.lsp.buf.declaration()<CR>", options)
    vim.api.nvim_set_keymap("n", "gd", "<cmd>lua vim.lsp.buf.definition()<CR>", options)
    vim.api.nvim_set_keymap("n", "K", "<cmd>lua vim.lsp.buf.hover()<CR>", options)
    vim.api.nvim_set_keymap("n", "gi", "<cmd>lua vim.lsp.buf.implementation()<CR>", options)
    vim.api.nvim_set_keymap("n", "gk", "<cmd>lua vim.lsp.buf.signature_help()<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>wa", "<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>wr", "<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>wl", "<cmd>lua print(vim.inspect(vim.lsp.buf.list_workspace_folders()))<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>D", "<cmd>lua vim.lsp.buf.type_definition()<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>rn", "<cmd>lua vim.lsp.buf.rename()<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>in", "<cmd>lua vim.lsp.buf.incoming_calls()<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>ca", "<cmd>lua vim.lsp.buf.code_action()<CR>", options)
    -- vim.api.nvim_set_keymap("n", "gr", "<cmd>lua vim.lsp.buf.references()<CR>",options)
    vim.api.nvim_set_keymap("n", "ge", "<cmd>lua vim.diagnostic.open_float()<CR>", options)
    vim.api.nvim_set_keymap("n", "[d", "<cmd>lua vim.diagnostic.goto_prev()<CR>", options)
    vim.api.nvim_set_keymap("n", "]d", "<cmd>lua vim.diagnostic.goto_next()<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>sl", "<cmd>lua vim.diagnostic.setloclist()<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>fm", "<cmd>lua vim.lsp.buf.formatting()<CR>", options)
end

M.comment = function()
    vim.api.nvim_set_keymap("n", "<c-_>", ":lua require('Comment.api').toggle_current_linewise()<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>/", ":lua require('Comment.api').toggle_current_linewise()<CR>", options)
    vim.api.nvim_set_keymap("n", "<leader>cl", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", options)
    vim.api.nvim_set_keymap("v", "<c-_>", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", options)
    vim.api.nvim_set_keymap("v", "<leader>/", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", options)
    vim.api.nvim_set_keymap("v", "<leader>cl", ":lua require('Comment.api').toggle_linewise_op(vim.fn.visualmode())<CR>", options)

end
M.hop = function()
    vim.api.nvim_set_keymap('n', '<leader>f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
    vim.api.nvim_set_keymap('n', '<leader>F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR })<cr>", {})
    vim.api.nvim_set_keymap('o', '<leader>f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
    vim.api.nvim_set_keymap('o', '<leader>F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})
    vim.api.nvim_set_keymap('v', '<leader>f', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.AFTER_CURSOR})<cr>", {})
    vim.api.nvim_set_keymap('v', '<leader>F', "<cmd>lua require'hop'.hint_char1({ direction = require'hop.hint'.HintDirection.BEFORE_CURSOR})<cr>", {})
    vim.api.nvim_set_keymap('', '<leader>l', '<cmd>HopLineStart<cr>', {})
    vim.api.nvim_set_keymap('', '<leader>j', '<cmd>HopLineStart<cr>', {})
    vim.api.nvim_set_keymap('', '<leader>k', '<cmd>HopLineStart<cr>', {})
    vim.cmd('hi HopNextKey guibg=#fabd2f guifg=#000000')
    vim.cmd('hi HopNextKey1 guibg=#fabd2f guifg=#000000')
    vim.cmd('hi HopUnmatched guifg=#928374')
end
M.trouble = function()
    vim.api.nvim_set_keymap("n", "<leader>xx", "<cmd>Trouble<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>xw", "<cmd>Trouble workspace_diagnostics<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>xd", "<cmd>Trouble document_diagnostics<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>xl", "<cmd>Trouble loclist<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>xq", "<cmd>Trouble quickfix<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "gR", "<cmd>Trouble lsp_references<cr>",
        { silent = true, noremap = true }
    )

end
M.symbols_outline = function()
    vim.api.nvim_set_keymap("n", "<leader>tt", "<cmd>SymbolsOutline<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("v", "<leader>tt", "<cmd>SymbolsOutline<cr>",
        { silent = true, noremap = true }
    )

end
M.harpoon = function()
    vim.api.nvim_set_keymap("n", "mf", "<cmd>lua require('harpoon.mark').add_file()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>mm", "<cmd>lua require('harpoon.ui').toggle_quick_menu()<cr>",
        { silent = true, noremap = true }
    )
    -- vim.api.nvim_set_keymap("v", "<leader>tt", "<cmd>SymbolsOutline<cr>",
    -- {silent = true, noremap = true}
    -- )
end
M.marks = function()
    -- vim.api.nvim_set_keymap("n", "mf", "<cmd>lua require('harpoon.mark').add_file()<cr>",
    -- {silent = true, noremap = true}
    -- )
    -- vim.api.nvim_set_keymap("n", "<leader>mm", "<cmd>lua require('karpoon.ui').toggle_quick_menu()<cr>",
    -- {silent = true, noremap = true}
    -- )
    -- vim.api.nvim_set_keymap("v", "<leader>tt", "<cmd>SymbolsOutline<cr>",
    -- {silent = true, noremap = true}
    -- )
end
M.debug = function()
    vim.api.nvim_set_keymap("n", "<leader>dt", "<cmd>lua require'dap'.toggle_breakpoint()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>db", "<cmd>lua require'dap'.step_back()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>dc", "<cmd>lua require'dap'.continue()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>dC", "<cmd>lua require'dap'.run_to_cursor()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>dd", "<cmd>lua require'dap'.disconnect()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>dg", "<cmd>lua require'dap'.session()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>di", "<cmd>lua require'dap'.step_into()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>do", "<cmd>lua require'dap'.step_over()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>du", "<cmd>lua require'dap'.step_out()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<f6>", "<cmd>lua require'dap'.step_into()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<f7>", "<cmd>lua require'dap'.step_over()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<f8>", "<cmd>lua require'dap'.step_out()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>dp", "<cmd>lua require'dap'.pause.toggle()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>dr", "<cmd>lua require'dap'.repl.toggle()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>ds", "<cmd>lua require'dap'.continue()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<F5>", "<cmd>lua require'dap'.continue()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>dq", "<cmd>lua require'dap'.terminate()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<F4>", "<cmd>lua require'dap'.terminate()<cr>",
        { silent = true, noremap = true }
    )
    vim.api.nvim_set_keymap("n", "<leader>dk", "<cmd>lua require'dapui'.eval()<cr>",
        { silent = true, noremap = true }
    )
end
return M
