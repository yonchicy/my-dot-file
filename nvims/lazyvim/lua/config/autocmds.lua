-- Autocmds are automatically loaded on the VeryLazy event
-- Default autocmds that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/autocmds.lua
-- Add any additional autocmds here

vim.api.nvim_create_autocmd({"BufEnter","TermOpen"}, {
    pattern= "term://*",
    callback = function ()
        vim.keymap.set("n","<leader>cd","<c-w>F<cmd>only<CR>",{silent=true,noremap=true,buffer=true,desc = "go to file"})
    end
}
)

